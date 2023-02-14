
#!/bin/bash

#############################################################################################
#Script Name   :release_image_4_0.sh                                                               
#Author        :DIVAGAR N                                                
#Email         :n.divagar@mobiveil.co.in                                          
#############################################################################################


read -p "Enter the name for the New image: " image_name
read -p "Enter the tag for the New image: " tag

sudo docker build -t  $image_name:$tag .

sudo docker login -u "nimbushaystack" -p "cogniCOGNI1!"

sudo docker push $image_name:$tag
