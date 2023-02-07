#! /usr/bin/bash

#############################################################################################
#Script Name   :initial_board_setup.sh                                                               
#Description   :This script dones all the base setup of the new board ready for the process.                              
#Author        :DIVAGAR N                                                
#Email         :n.divagar@mobiveil.co.in                                          
#############################################################################################

clear  
echo "#####################################################################################" 
echo "                       Board preparation procudure starts" 
echo "#####################################################################################"

echo 'haystack' | sudo -S apt-get update  ##This is the initial apt-get update 
#source /opt/ros/noetic/setub.bash

##These are to create folders and subfolders
cd /
sudo mkdir haystack_disinfect_report && echo "sucessfully created haystack_disinfect_report"
cd haystack_disinfect_report
sudo mkdir images
sudo mkdir database
cd ..
cd 

##This to copy the usb rules to the /etc/udev/rules.d/

git clone https://<userid>:<tokenid>@github.com/haystack-nimbus/run_script.git
    
cd run_script/install
sudo cp 10-local.rules  /etc/udev/rules.d/ && echo "usb rules file sucessfully created"
sudo cp 99-realsense-libusb.rules /etc/udev/rules.d/ && echo "camera rules file sucessfully created"
sudo cp robot_config.ini /haystack_disinfect_report/


##This is for the wallpaper1
sudo cp Haystack_Logo.png /usr/share/backgrounds/NVIDIA_Login_Logo.png && echo "splash screen walpaper changed"

##This is for the wallpaper2
gsettings set org.gnome.desktop.background picture-uri file:////home/haystack/run_script/install/Haystack_ScreenSaver.png && echo "desktop walpaper changed"

cd

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
#sudo touch /etc/init.d/xrandr-startup
#cd /etc/init.d
#chmod +x xrandr-startup
#cd
sudo touch screenrotate.sh
echo -e "#! /usr/bin/bash\nxrandr -o left\nxhost +\nxrandr --size 1280x720" | sudo tee screenrotate.sh
chmod +x screenrotate.sh

sudo touch screenrotate.py
echo 'import subprocess' >> screenrotate.py
echo 'subprocess.run(["/bin/bash", "/home/haystack/screenrotate.sh"])' >> screenrotate.py

sudo touch /etc/systemd/system/screenrotate.service
echo -e "[Unit]\nDescription=This script is to rotate the sreen\n[Service]\nUser=root\nExecStart=python3 /home/haystack/screenrotate.py\nRestart=always\n[Install]\nWantedBy=multi-user.target" | sudo tee /etc/systemd/system/screenrotate.service

sudo systemctl daemon-reload
sudo systemctl enable screenrotate.service
sudo systemctl start screenrotate.service

##service for the hwclock sync
sudo touch /etc/systemd/system/haystack-hwclock.service
echo -e "[Unit]\nDescription=Haystack HWclock service\n[Service]\nUser=root\nExecStart=hwclock --hwtosys\nRestart=always\nRestartSec=10\n[Install]\nWantedBy=multi-user.target" | sudo tee /etc/systemd/system/haystack-hwclock.service

sudo systemctl daemon-reload
sudo systemctl enable haystack-hwclock.service
sudo systemctl start haystack-hwclock.service

#echo -e "xhost +\nxrandr --size 1280x720\nxrandr -o left" | sudo tee /etc/init.d/xrandr-startup

#sudo update-rc.d xrandr-startup defaults



##This is to stop the Disable Error / Crash Report Popup
enabled=1
sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport

##This is to enable automatic login in ubuntu
sudo sed -i 's/#  AutomaticLoginEnable = true/  AutomaticLoginEnable = true/g' /etc/gdm3/custom.conf

sudo sed -i 's/#  AutomaticLogin = user1/  AutomaticLogin = haystack/g' /etc/gdm3/custom.conf

##This is for the touch calibration 
sudo apt-get install xserver-xorg-input-libinput
mkdir -p /etc/X11/xorg.conf.d
sudo cp /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d/
sudo sed -i '43s/^/        Option "CalibrationMatrix" "0 -1 1 1 0 0 0 0 1"\n/' /etc/X11/xorg.conf.d/40-libinput.conf 


##This is for the screen scaver
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'

##This is to hide the topbar
echo "gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Eval string:'Main.panel.actor.hide();' > /dev/null 2>&1" >> ~/.bashrc

#This is to hide the dock 
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.DisableExtension ubuntu-dock@ubuntu.com

##To prevent the screen sleep 
gsettings set org.gnome.desktop.session idle-delay 0

##This is to stop and disable bluetooth service
sudo systemctl stop bluetooth.service
sudo systemctl disable bluetooth.service

echo "all finished"

##asks user permission to reboot the system

echo "Do you want to reboot the system now? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
    echo "Rebooting now..."
    sudo reboot
else
    echo "Reboot cancelled."
fi
