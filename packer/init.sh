#!/bin/bash

echo thiss > /home/ubuntu/test.txt

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx