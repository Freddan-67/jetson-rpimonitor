# rpimonitor-jetson
rpimonitor for jetson nano devices.
I have created an adaption of the excellent work from https://github.com/XavierBerger/RPi-Monitor to adapt rpimonitor to my jetson devices

short file description
nvidia.png logotype
cpu3.conf is for the cpu
temperature3.conf is for SBC's with six sensors
storage.conf is for sd-card and USB storage
wlan.conf is one wifi card
jetson.conf is the replacer for raspian.conf
uptime3.conf replaced the word "raspbian" with "jetson nano"

I did debug device tree and check for suspect voltage regulators with microvolt-create.sh
it can create a file used to read the voltages from the different regulators
microvolt-create.sh > microvolt.sh
In microvolt.sh I get a list of voltage regulator for the device I am currently running.

Temperature sensors 
They are all placed in /sys/devices/virtual/thermal/thermal_zone[0-9]/temp

There are six sensors on jetson nano. One is always 100 degrees so I have removed it from statistics

They purpose can be found in /sys/devices/virtual/thermal/thermal_zone[0-9]/type (gpu-thermal, soc-thermal or cpu-thermal)

A general rule is that keep your data names short. The rpimonitor seems to like max 8 character long names for statistics.

install
On jetson nano you need perl and some libraries
sudo apt -y install perl libhttp-daemon-perl libjson-perl libsnmp-extension-passpersist-perl 
sudo apt -y install librrds-perl libfile-which-perl 
sudo apt -y install libencode-locale-perl  liblwp-mediatypes-perl libio-html-perl liburi-perl

first install rpimonitor, you should select the right init. For debian I use systemV
testrun that rpimonitor do not crash because of I forgot to list a needed perl library by running it in foreground

sudo rpimonitord
if everything works you can access your armbiandevice

direct a web browser to the IP of your armbian device, port 8888
My router tells me devices with adress on my network if they are configured with avahi.
Activate avahi in armbian-config.
in my example http://192.168.1.13:8888

files
#nvidia.png should go to /usr/share/rpimonitor/web/img/
sudo cp nvidia.png /usr/share/rpimonitor/web/img/
#all the conf files shold go to /etc/rpimonitor/template
sudo cp *.conf /etc/rpimonitor/template
#the soft link /etc/rpimonitor/data.conf should be relinked to /etc/rpimonitor/template/jetson.conf
sudo rm /etc/rpimonitor/data.conf
sudo ln -s /etc/rpimonitor/template/jetson.conf /etc/rpimonitor/data.conf
#the service should be restarted
sudo systemctl rpimonitor stop
sudo systemctl rpimonitor start

kill the foreground process and start the deamon
sudo systemctl rpimonitor start
check that the deamon runs
ps -efl|grep rpimon
