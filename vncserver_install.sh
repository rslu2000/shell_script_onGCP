STIME=`date`
sudo apt-get update -y
sudo apt-get install ubuntu-desktop -y
sudo apt-get install vnc4server -y
sudo apt-get install metacity -y
sudo apt-get install gnome-panel -y
sudo apt-get install gnome-settings-daemon -y
sudo apt-get install nautilus -y
sudo vncserver
sudo vncserver -kill :1
cd
sudo cp xstartup .vnc/
sudo vncserver
ETIME=`date`
echo $STIME,$ETIME 
