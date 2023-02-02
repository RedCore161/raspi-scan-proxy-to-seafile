#!/bin/bash

cd /home/pi/raspi-scan-proxy-to-seafile || exit

git pull
date '+%Y-%m-%d %H:%M:%S - Pulled Repo' >> service.log

for i in {1..30}; do
  bash /home/pi/raspi-scan-proxy-to-seafile/scan_folder.sh
  RESULT=$?
  echo "[RESULT] $RESULT $i/30"
  date '+%Y-%m-%d %H:%M:%S - Scanned Folder' >> service.log
  sleep 60
done

