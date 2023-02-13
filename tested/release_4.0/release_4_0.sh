#!/bin/bash

#############################################################################################
#Script Name   :release_image_4_0.sh                                                               
#Author        :DIVAGAR N                                                
#Email         :n.divagar@mobiveil.co.in                                          
#############################################################################################


read -p "Enter the name for the New image: " image_name
read -p "Enter the tag for the New image: " tag


read -p "Enter the user id of github: " user_id
read -p "Enter the token : " token_id

# Create a new Dockerfile
echo "#!/bin/bash" > Dockerfile
echo "#Base Image as L4T for jetpack 5.0.2" >> Dockerfile
echo "ARG BASE_IMAGE=nimbushaystack/haystack_noetic_person_follower_base:v0.0" >> Dockerfile
echo "FROM ${BASE_IMAGE}" >> Dockerfile
echo "ENV DEBIAN_FRONTEND=noninteractive" >> Dockerfile
echo "RUN rm -rf /haystack_ws/src " >> Dockerfile

echo "RUN git clone https://$user_id:$token_id@github.com/haystack-nimbus/src.git -b noetic-main" >> Dockerfile

echo "RUN ["/bin/bash", "-c", "source /opt/ros/noetic/setup.bash && cd /haystack_ws && catkin_make -j4"]" >> Dockerfile

echo "WORKDIR /haystack_ws/src/haystack/ui" >> Dockerfile

# Build the new image
sudo docker build --no-cache -t $image_name:$tag .

sudo docker login -u "nimbushaystack" -p "cogniCOGNI1!"

sudo docker push $image_name:$tag

