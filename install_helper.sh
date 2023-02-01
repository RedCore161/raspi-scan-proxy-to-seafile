#!/bin/bash

apt update
apt install -y jq git

cd /home/pi/ || exit

git clone RedCore161/raspi-scan-proxy-to-seafile
cd /home/pi/raspi-scan-proxy-to-seafile || exit

# Create Service
cat <<EOT >> /etc/systemd/system/update_repo.service
[Unit]
Description=Update the git-repo
After=network.target

[Service]
Type=simple
ExecStart=/home/pi/raspi-scan-proxy-to-seafile/updater.sh
TimeoutStartSec=0

[Install]
WantedBy=default.target
EOT
systemctl daemon-reload
systemctl start update_repo.service

date '+%Y-%m-%d %H:%M:%S - Startet Service' >> service.log
