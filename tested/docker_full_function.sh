#!/bin/bash

echo "Welcome to the Docker builder and pusher script!"
echo "Please select an option:"
echo "1. Pull an existing Docker image from Docker Hub"
echo "2. Build a new Docker image and push to Docker Hub"
echo "3. Build a new Base Docker image without src"
echo "4. to clone the git source file to the Base image"

read -p "Selection: " choice

if [ $choice -eq 1 ]; then
  read -p "Enter the name of the image to pull: " image_name
  read -p "Enter the name of the tag to pull: " tag
  sudo docker pull $image_name:$tag
  
elif [ $choice -eq 2 ]; then
  read -p "Enter the name for the new image: " image_name
  read -p "Enter the tag for the image: " tag

  #docker build -t $image_name:$tag -f $dockerfile_path .
  sudo docker build -t $image_name:$tag .
  
  sudo docker login -u "nimbushaystack" -p "cogniCOGNI1!"

  echo "Pushing image to Docker Hub..."
  sudo docker push $image_name:$tag
  
elif [ $choice -eq 3 ]; then
  cd without_src
  read -p "Enter the name for the base existing image: " image_name
  read -p "Enter the tag for the base existing image: " tag
  echo "now the build starts."
  
  sudo docker build -t $image_name:$tag .
  
  echo "now the build image starts pushing to the hub."
  
  sudo docker push $image_name:$tag
  
##this step 4 not tested fully

elif [ $choice -eq 4 ]; then
  read -p "Enter the name for the base existing image: " base_image_name
  read -p "Enter the tag for the base existing image: " base_tag
  sudo docker pull $base_image_name:$base_tag
  echo "pull completed"
  
  read -p "Enter the name for the new image: " image_name
  read -p "Enter the tag for the image: " tag
  
  sudo docker kill base_run 
  sudo docker run --name "base_run" -it $base_image_name:$base_tag bash && \
  sudo docker exec -it -w /haystack_ws base_run git clone https://<username>:<tokenid>@github.com/haystack-nimbus/src.git && \
  sudo docker exec -it -w /haystack_ws base_run bash -c "source /opt/ros/noetic/setup.bash && catkin_make"
  
  sudo docker commit base_run $image_name:$tag
  sudo docker login -u "nimbushaystack" -p "cogniCOGNI1!"
  
  sudo docker push $image_name:$tag
  echo "source added and pushed to the hub."
  
else
  echo "Invalid selection. Please try again."
fi
                                                                                                                                                
