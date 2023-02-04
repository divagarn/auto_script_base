#!/bin/bash

# Stop all running containers
sudo docker stop $(docker ps -aq)

# Remove all containers
sudo docker rm $(docker ps -aq)

# Remove all images that are not used in any containers
sudo docker rmi $(docker images -q -f "dangling=true")

# Build the new image with a specified tag

read -p "Enter the name for the new image (eg; reponame/imagename) : " image_name
read -p "Enter the tag for the image: " tag


sudo docker build -t $image_name:$tag .

# Run the newly built image
#sudo docker run -it <image_tag>

