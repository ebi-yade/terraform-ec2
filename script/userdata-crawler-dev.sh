#!/bin/bash

set -eux

# install packages
yum -y update
yum install -y git  \
                golang

# download project files
cd /home/ec2-user
git clone https://github.com/ebi-yade/crawler # clone this repo
#aws s3 cp s3://crawler-ebi-dev/dotfiles/.env /crawler/.env # get .env on s3 with default encription

# change owner of project directory
chown -R ec2-user:ec2-user ./crawler