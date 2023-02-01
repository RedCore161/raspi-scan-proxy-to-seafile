#!/bin/bash

cd /home/pi/raspi-scan-proxy-to-seafile || exit

git pull
date '+%Y-%m-%d %H:%M:%S - Pulled Repo' >> service.log

bash /home/pi/raspi-scan-proxy-to-seafile/scan_folder.sh
date '+%Y-%m-%d %H:%M:%S - Scanned Folder' >> service.log
