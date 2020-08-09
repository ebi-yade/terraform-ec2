#!/bin/bash

set -eux

# install packages
yum -y update
yum install -y git  \
                golang

# add project files
cd /home/ec2-user

# change owner of project directory
chown -R ec2-user:ec2-user ./crawler