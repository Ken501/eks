#!/bin/sh
sudo apt update
# Install Apache web server
sudo apt install apache2 -y
sudo a2enmod ssl
sudo systemctl start apache2
sudo systemctl enable apache2