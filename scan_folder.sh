#!/bin/bash

export $(grep -v '^#' .env | xargs)

if [[ -z "$scan_dir" ]]; then
    echo "Must provide $scan_dir in .env" 1>&2
    exit 1
fi
if [[ -z "$server" ]]; then
    echo "Must provide $server in .env" 1>&2
    exit 1
fi
if [[ -z "$repo" ]]; then
    echo "Must provide $repo in .env" 1>&2
    exit 1
fi
if [[ -z "$user" ]]; then
    echo "Must provide $user in .env" 1>&2
    exit 1
fi
if [[ -z "$pw" ]]; then
    echo "Must provide $pw in .env" 1>&2
    exit 1
fi

target_dir="$(pwd)/${scan_dir}"

mkdir -p "$(pwd)/processed"
mkdir -p "$target_dir"

echo "[INFO] Scanning: $target_dir"
for entry in "$target_dir"/*
do
  if [ "${entry: -1}" != '*' ]; then
    echo "[INFO] Push to upload => ${entry} | $(basename $entry)"
    echo "[INFO] $entry | $server | $repo | $user | $pw | $scan_dir"
    bash ./upload_scan.sh "$entry" "$server" "$repo" "$user" "$pw" "$scan_dir"
    RESULT=$?
    if [ $RESULT -eq 0 ]; then
      echo "[INFO] Finished scanning: $entry"
      mv "${entry}" "$(pwd)/processed/$(basename $entry)"
    fi
  fi
done
echo "[INFO] Done!"
