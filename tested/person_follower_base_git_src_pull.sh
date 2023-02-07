#!/bin/bash

#############################################################################################
#Script Name   :person_follower_base_git_src_pull.sh                                                               
#Author        :DIVAGAR N                                                
#Email         :n.divagar@mobiveil.co.in                                          
#############################################################################################

# Pull person follower base Docker image
sudo docker pull nimbushaystack/haystack_noetic_person_follower_base:v0.0

sudo docker stop haystack
sudo docker rm haystack

# Run a new container from the image and name it
sudo docker run -it -w /haystack_ws/ -d --env /opt/ros/noetic/setup.bash --privileged --name "haystack" nimbushaystack/haystack_noetic_person_follower_base:v0.0

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
