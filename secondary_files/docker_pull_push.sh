#!/bin/bash

#echo "Welcome to the Docker management script!"

#echo "Please select an option:"
#echo "1) Pull existing Docker image"
#echo "2) Build new Docker image"

#read option

#if [ $option == 1 ]; then
#    echo "Enter the name of the Docker image to pull:"
#    read image_name
#    docker pull $image_name

#elif [ $option == 2 ]; then
#    echo "Enter the name of the new Docker image:"
#    read new_image_name
#    echo "Enter the path to the Dockerfile:"
#    read path_to_dockerfile
#    docker build -t $new_image_name $path_to_dockerfile

#else
#    echo "Invalid option selected. Exiting script."
#    exit 1
#fi




echo "Welcome to the Docker builder and pusher script!"
echo "Please select an option:"
echo "1. Pull an existing Docker image from Docker Hub"
echo "2. Build a new Docker image and push to Docker Hub"

read -p "Selection: " choice

if [ $choice -eq 1 ]; then
  read -p "Enter the name of the image to pull: " image_name
  read -p "Enter the name of the tag to pull: " tag
  docker pull $image_name:$tag
  
elif [ $choice -eq 2 ]; then
  read -p "Enter the name for the new image: " image_name
  #read -p "Enter the path to the Dockerfile: " dockerfile_path
  read -p "Enter the tag for the image: " tag

  #docker build -t $image_name:$tag -f $dockerfile_path .
  sudo docker build -t $image_name:$tag .

  # Commit the image to a new repository
  sudo docker kill diva
  sudo docker run --name "diva" nimbushaystack/$image_name:$tag
  sudo docker commit diva nimbushaystack/$image_name:$tag
  #additional line 
  #sudo docker tag $image_name:$tag nimbushaystack/$image_name:$tag
  
  sudo docker login -u "nimbushaystack" -p "cogniCOGNI1!"
  
  
  #container_id=$(sudo docker ps -aq --filter ancestor=$image_name:$tag)
  #sudo docker commit $container_id $new_repo/$image_name:$tag
  #sudo docker commit $container_id $image_name:$tag
  
  #read -p "Enter your Docker Hub username: " username
  #read -p "Enter your Docker Hub password: " -s password
  #echo ""

  #echo "Logging in to Docker Hub..."
  #echo $username
  #echo $password
  #echo $username:$password | docker login --username $username --password-stdin

  echo "Pushing image to Docker Hub..."
  sudo docker push nimbushaystack/$image_name:$tag
else
  echo "Invalid selection. Please try again."
fi
                                                                                                                                                
