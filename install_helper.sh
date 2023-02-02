#!/bin/bash

apt update
apt install -y jq git samba samba-common-bin

mkdir -p /home/pi/raspi-scan-proxy-to-seafile/scan

cd /home/pi/ || exit

git clone RedCore161/raspi-scan-proxy-to-seafile
cd /home/pi/raspi-scan-proxy-to-seafile || exit

#smbpasswd -a pi #TODO

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

# Create Samba-Dir
cat <<EOT >> /etc/samba/smb.conf
[piscan]
  comment = Pi Home
  path = /home/pi/raspi-scan-proxy-to-seafile/scan
  browseable = yes
  writeable = yes
  force create mode = 0777
  force directory mode = 0777
  public = yes
EOT

systemctl daemon-reload
systemctl start update_repo.service
systemctl restart smbd

date '+%Y-%m-%d %H:%M:%S - Started Service' >> service.log
