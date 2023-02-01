#!/bin/bash

cd /home/pi/raspi-scan-proxy-to-seafile || exit

git pull

date '+%Y-%m-%d %H:%M:%S - Pulled Repo' >> service.log
