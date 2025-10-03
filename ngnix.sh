
#!bin/bash

sudo apt-get update
sudo apt-get install ngnix -y
sudo systemctl start ngnix
sudo systemctl enable ngnix

echo "<h1> Terraform with ngnix </h1>" | sudo tee /var/www/html/index.html