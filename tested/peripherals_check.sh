#!/bin/bash

#############################################################################################
#Script Name   :peripherals_check.sh                                                               
#Author        :DIVAGAR N                                                
#Email         :n.divagar@mobiveil.co.in                                          
#############################################################################################

echo "Welcome to the peripherals check script!"
echo "Please select an option:"
echo "1. Check the peripherals in dev folder"
echo "2. Check the peripherals using lsusb"
echo "3. Check the rostopic --> note: run after the master launch: "

read -p "Selection: " choice

if [ $choice -eq 1 ]; then

  # Check if a lidar is present in the /dev folder
  echo "Checking for lidar in /dev folder..."
  if [ -e "/dev/lidar" ]; then
    echo "lidar found"
  else
    echo "lidar not found"
  fi

  echo "Checking for arduino in /dev folder..."
  if [ -e "/dev/arduino" ]; then
    echo "arduino found"
  else
    echo "arduino not found"
  fi

  echo "Checking for battery_can in /dev folder..."
  if [ -e "/dev/battery" ]; then
    echo "battery_can found"
  else
    echo "battery_can not found"
  fi
  
elif [ $choice -eq 2 ]; then
  echo "Checking for LIDAR..."
  read -p "Enter the id: " id
  lsusb | grep $id
  if [ $? -eq 0 ]; then
    echo "Given id is found"
  else
    echo "Given id is not found"
  fi

elif [ $choice -eq 3 ]; then
  echo "Checking ROS topics..."

  # Get a list of all the ROS topics
  topics=($(rostopic list))

  # Loop through the list of topics
  for topic in "${topics[@]}"; do

    # Check if the topic is being received correctly
    result=$(rostopic echo $topic)
    if [ $? -eq 0 ]; then
      echo "Topic $topic is being received correctly"
    else
      echo "Failed to receive topic $topic"
    fi

  done

  echo "ROS topic check complete"
