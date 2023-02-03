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
  

elif [ $choice -eq 4 ]; then
  read -p "Enter the name for the base existing image: " base_image_name
  read -p "Enter the tag for the base existing image: " base_tag
  # Pull existing Docker image
  sudo docker pull $base_image_name:$base_tag

  sudo docker stop haystack
  sudo docker rm haystack
  # Run a new container from the image and name it
  sudo docker run -it -w /haystack_ws/ -d --env /opt/ros/noetic/setup.bash --privileged --name "haystack" $base_image_name:$base_tag top

  # Clone a Git repository inside the container
  sudo docker exec -w /haystack_ws haystack git clone https://<userid>:<tokenid>@github.com/haystack-nimbus/src.git -b noetic-main
  sudo docker exec -w /haystack_ws haystack bash -c "source /opt/ros/noetic/setup.bash ; cd /haystack_ws ;catkin_make"
  sudo docker exec -w /haystack_ws/src/haystack/ui haystack echo "changed"
  
  read -p "Enter the name for the New image: " image_name
  read -p "Enter the tag for the New image: " tag
  # Commit the changes to the Docker image
  sudo docker commit haystack $image_name:$tag
  
  sudo docker login -u "nimbushaystack" -p "cogniCOGNI1!"
  # Push the updated image to Docker Hub
  sudo docker push $image_name:$tag
  # Stop and remove the named container
  sudo docker stop haystack
  sudo docker rm haystack

else
  echo "Invalid selection. Please try again."
fi
                                                                                                                                                
