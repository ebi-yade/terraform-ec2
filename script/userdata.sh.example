#!/bin/bash

set -eux

if [ ! -e "/check" ]
then
    touch /check
    echo "-- First container startup --"
    # install packages
    #sudo yum -y update
    #sudo yum install -y git \
    #                    golang

    cd /home/ec2-user
    if [ "local" != $APP_ENV ]
    then
        # download project files
        git clone https://github.com/ebi-yade/crawler # clone this repo
        #aws s3 cp s3://crawler-ebi-dev/dotfiles/.env /crawler/.env # get .env on s3 with default encription
    else
        chmod 646 /dev/pts/0
    fi
    # change owner of project directory
    chown -R ec2-user:ec2-user ./crawler
else
    echo "-- Not first container startup --"
fi