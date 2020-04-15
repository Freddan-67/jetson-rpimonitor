#!/bin/bash
#install prerequisits
sudo apt -y install perl libhttp-daemon-perl libjson-perl libsnmp-extension-passpersist-perl 
sudo apt -y install librrds-perl libfile-which-perl 
sudo apt -y install libencode-locale-perl liblwp-mediatypes-perl libio-html-perl liburi-perl
sudo apt -y install libipc-sharelite-perl aptitude
#The logo file goes to web directory
#in my case  /usr/share/rpimonitor/web/img/
sudo cp nvidia.png /usr/share/rpimonitor/web/img

#the *.conf files goes to the etc dir structure /etc/rpimonitor/tempate
sudo cp cpu3.conf storage.conf wlan.conf /etc/rpimonitor/template
sudo cp jetson.conf temperature3.conf uptime3.conf /etc/rpimonitor/template

#the symbolic link /etc/rpimonitor/data.conf shall point to /etc/rpimonitor/jetson.conf
sudo rm /etc/rpimonitor/data.conf
sudo ln -s /etc/rpimonitor/template/jetson.conf /etc/rpimonitor/data.conf

#the service shall be restarted
sudo systemctl stop rpimonitor
sudo systemctl start rpimonitor 
#or
#sudo service rpimonitor stop
#sudo service rpimonitor start
