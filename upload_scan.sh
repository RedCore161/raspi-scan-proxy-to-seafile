#!/bin/bash

echo "Get Auth-token from server=${2}"
token=$(curl -d "username=${4}&password=${5}" "${2}/api2/auth-token/" | jq -r ".token")
echo "[INFO] token=${token}"

echo "Get Upload-Link..."
link=$(curl -H "Authorization: Token ${token}" "${2}/api2/repos/${3}/upload-link/ "| tr -d '"')
echo "[INFO] link=${link}"

echo "Upload file=${1}"
result=$(curl -H "Authorization: Token ${token}" -F file="@${1}" -F filename="${1}" -F parent_dir=/ $link)
echo "[RESULT] ${result}"
