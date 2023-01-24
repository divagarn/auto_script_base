#! /usr/bin/bash

###################################################################
#Script Name   :docker_installation.sh                                                               
#Description   :This script checks and installs docker                              
#Author        :DIVAGAR N                                                
#Email         :n.divagar@mobiveil.co.in                                          
###################################################################

clear  
echo "#####################################################################################" 
echo "                       Docker Installation Procedure Starts" 
echo "#####################################################################################" 

#sudo apt-get update

#sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#sudo apt-get update

#sudo apt-get install -y docker-ce



which docker

if [ $? -eq 0 ]
then
    docker --version | grep "Docker version"
    if [ $? -eq 0 ]
    then
        echo "docker existing"
    else
        echo "installing docker"
        
        sudo apt-get update

	sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

	sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

	sudo apt-get update

	sudo apt-get install -y docker-ce
    fi
else
    echo "install docker" >&2
fi

echo "#########################Docker installation finished ######################################" 


echo "Welcome to the Docker management script!"

echo "Please select an option:"
echo "1) Pull existing Docker image"
echo "2) Build new Docker image"
echo "Enter the option: "
read option

if [ $option == 1 ]; then
    echo "Enter the name of the Docker image to pull:"

echo "#####################################################################################" 
echo "                       Docker Installation Procedure Finished!" 
echo "#####################################################################################"
