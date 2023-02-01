#!/bin/bash

export $(grep -v '^#' .env | xargs)

target_dir="$(pwd)/${scan_dir}"

mkdir -p "$(pwd)/processed"
mkdir -p "$target_dir"

echo "[INFO] Scanning: $target_dir"
for entry in "$target_dir"/*
do
  if [ "${entry: -1}" != '*' ]; then
    echo "[INFO] Push to upload => ${entry} | $(basename $entry)"
    bash ./upload_scan.sh "$entry"
    mv "${entry}" "$(pwd)/processed/$(basename $entry)"
  fi
done
echo "[INFO] Done!"
