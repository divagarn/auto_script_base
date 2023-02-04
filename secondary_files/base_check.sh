#!/bin/bash

# Check if the specified partition is present
partition="/dev/sda1"
if [ ! -b "$partition" ]; then
  echo "Error: $partition not found."
  exit 1
fi

# Check if the specified folders are present
folders=("/var/log" "/etc" "/usr/local")
for folder in "${folders[@]}"; do
  if [ ! -d "$folder" ]; then
    echo "Error: $folder not found."
    exit 1
  fi
done

echo "Partition and folders are present."

