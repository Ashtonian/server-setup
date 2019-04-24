#!/bin/bash
login=""
pass=""
host=""
remote_dir='~/files/completed/'
local_dir="/mnt/temp/lftp/"

base_name="$(basename "$0")"
lock_file="/tmp/$base_name.lock"
trap "rm -f $lock_file; exit 0" SIGINT SIGTERM
if [[ -e "$lock_file" ]]
then
    echo "$base_name is running already."
    exit
else
    touch "$lock_file"
    lftp -p 22 -u "$login","$pass" sftp://"$host" << EOF
    set sftp:auto-confirm yes
    set mirror:use-pget-n 5
    set xfer:use-temp-file yes
    set xfer:temp-file-name *.lftp
    mirror --exclude-glob "\.(?:rar|r\d\d|\d\d\d)$" --Remove-source-dirs --loop --no-perms -c -P5 --log="/mnt/temp/$base_name.log" "$remote_dir" "$local_dir"
    quit
EOF
    rm -f "$lock_file"
    trap - SIGINT SIGTERM
    exit
fi


#  unused due to rtorrent settings