#!/bin/bash

#############################################################################################
#Script Name   :release_image_4_0.sh                                                               
#Author        :DIVAGAR N                                                
#Email         :n.divagar@mobiveil.co.in                                          
#############################################################################################


read -p "Enter the name for the New image: " image_name
read -p "Enter the tag for the New image: " tag
read -p "Enter the user name to the git: " user_name
read -p "Enter the token id of git: " token_name

export tag_ver=$tag
export user_id=$user_name
export token_id=$token_name
export message=$tag
echo $tag_ver

sudo docker build  --build-arg token_id=${token_id} --build-arg user_id=${user_id} --build-arg tag_ver=${tag_ver} --no-cache -t  $image_name:$tag .

sudo docker login -u "nimbushaystack" -p "cogniCOGNI1!"

sudo docker push $image_name:$tag
