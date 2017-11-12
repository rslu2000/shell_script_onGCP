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
sudo apt-get install x11vnc -y
sudo x11vnc --storepasswd /opt/x11vnc.pwd
sudo x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth /opt/x11vnc.pwd -rfbport 5900 -shared -display :1 &
git clone https://github.com/kanaka/noVNC
cd noVNC
nohup ./utils/launch.sh --vnc localhost:5900 --listen 6080 &

ETIME=`date`
echo $STIME,$ETIME 
