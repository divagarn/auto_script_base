#!/bin/bash

echo "Welcome to the Docker management script!"

echo "Please select an option:"
echo "1) Pull existing Docker image"
echo "2) Build new Docker image"

read option

if [ $option == 1 ]; then
    echo "Enter the name of the Docker image to pull:"
    read image_name
    docker pull $image_name

elif [ $option == 2 ]; then
    echo "Enter the name of the new Docker image:"
    read new_image_name
    echo "Enter the path to the Dockerfile:"
    read path_to_dockerfile
    docker build -t $new_image_name $path_to_dockerfile

else
    echo "Invalid option selected. Exiting script."
    exit 1
fi

