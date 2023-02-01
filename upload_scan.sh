#!/bin/bash

echo "Get Auth-token from server: ${server}"
token=$(curl -d "username=${user}&password=${pw}" "${server}/api2/auth-token/" | jq -r ".token")
echo "[INFO] token=${token}"

echo "Get Upload-Link..."
link=$(curl -H "Authorization: Token ${token}" "${server}/api2/repos/${repo}/upload-link/ "| tr -d '"')
echo "[INFO] link=${link}"

echo "Upload... ${1}"
result=$(curl -H "Authorization: Token ${token}" -F file="@${1}" -F filename="${1}" -F parent_dir=/ $link)
echo "[RESULT] ${result}"
echo
