#! /usr/bin/bash
echo 'haystack' | sudo -S apt-get update  ##This is the initial apt-get update 
#source /opt/ros/noetic/setub.bash

##These are to create folders and subfolders
mkdir haystack_disinfect_report
cd haystack_disinfect_report
mkdir images
mkdir database
cd ..
#mkdir catkin_ws 
#cd catkin_ws
#mkdir src 
#cd src

##This to copy the usb rules to the /etc/udev/rules.d/

git clone https://HariharanMobiveil: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@github.com/haystack-nimbus/run_script.git

cd run_script/install
sudo cp 10-local.rules  /etc/udev/rules.d/
cp robot_config.ini /home/haystack/haystack_disinfect_report/


##This is for the wallpaper1
sudo cp Haystack_Logo.png /usr/share/backgrounds/NVIDIA_Login_Logo.png

##This is for the wallpaper2
gsettings set org.gnome.desktop.background picture-uri file:////home/haystack/run_script/install/Haystack_ScreenSaver.png
#cd ~/catkin_ws
#catkin_make
cd
echo 'xhost +' >> ~/.bashrc

##this is to install gnome shell
sudo apt-get install -y gnome-shell-extensions
sudo apt-get install -y gnome-shell-extension-autohidetopbar

##This is to hide the trash and home icon
gsettings set org.gnome.shell.extensions.desktop-icons show-trash false
gsettings set org.gnome.shell.extensions.desktop-icons show-home false

##This is to delete all files in desktop
cd Desktop
rm -rf *
cd

##This is to change the screen orientation and screen resolution and add in .profile
#echo 'xrandr --size 1280x720' >> ~/.profile
#echo 'xrandr -o left'  >> ~/.profile
sudo touch /etc/init.d/xrandr-startup
echo 'xrandr --size 1280x720' >> /etc/init.d/xrandr-startup
echo 'xrandr -o left'  >> /etc/init.d/xrandr-startup
sudo update-rc.d xrandr-startup defaults



##This is to stop the Disable Error / Crash Report Popup
enabled=1
sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport

##This is to enable automatic login in ubuntu
sudo sed -i 's/#  AutomaticLoginEnable = true/  AutomaticLoginEnable = true/g' /etc/gdm3/custom.conf

sudo sed -i 's/#  AutomaticLogin = haystack/  AutomaticLogin = haystack/g' /etc/gdm3/custom.conf

##This is for the touch calibration 
sudo apt-get install xserver-xorg-input-libinput
mkdir -p /etc/X11/xorg.conf.d
sudo cp /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d/
sudo sed -i '43s/^/        Option "CalibrationMatrix" "0 -1 1 1 0 0 0 0 1"\n/' /etc/X11/xorg.conf.d/40-libinput.conf 


##This is to enable automatic login in ubuntu
sudo sed -i 's/#  AutomaticLoginEnable = true/  AutomaticLoginEnable = true/g' /etc/gdm3/custom.conf

sudo sed -i 's/#  AutomaticLogin = user1/  AutomaticLogin = haystack/g' /etc/gdm3/custom.conf

##This is for the screen scaver
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'

##This is to hide the topbar
echo "gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Eval string:'Main.panel.actor.hide();' " >> ~/.bashrc

#This is to hide the dock 
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.DisableExtension ubuntu-dock@ubuntu.com

##This is to stop and disable bluetooth service
sudo systemctl stop bluetooth.service
sudo systemctl disable bluetooth.service


echo "all finished"
sudo reboot 
