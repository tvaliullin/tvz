#!/bin/bash
#ПРАКТИЧЕСКОЕ ЗАДАНИЕ №2

#Напишите Bash-скрипт для резервного копирования директории /home, 
#конфигурационных файлов основных утилит удалённого доступа (SSH, RDP, FTP)- /etc/ssh /etc/xrdp /etc/vsftpd.conf 
#, а также директории /var/log.

# Files and Directories list for backup 
backup_files="/home /etc/ssh /etc/xrdp /etc/vsftpd.conf /var/log"

# Destination folder
dest="/archive/task2"

# Archive name - hostname-weekday
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Start message
echo "Backing up $backup_files to $dest/$archive_file"
date

# Copying by TAR
sudo tar czf $dest/$archive_file $backup_files

# Finish message
echo -e  "\n   Backup finished successfully!"
date

# Archive Files list
ls -lh $dest
