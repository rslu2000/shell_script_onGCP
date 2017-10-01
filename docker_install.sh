sudo apt-get update
curl -sSL https://get.docker.com/ | sh
sudo usermod -a -G docker $USER
sudo apt-get install docker-compose -y
sudo reboot

