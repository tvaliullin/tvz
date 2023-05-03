#!/bin/bash
#ПРАКТИЧЕСКОЕ ЗАДАНИЕ №1

#1.Проверка на наличие репозитория Backports в списке репозиториев. 
#Если отсутствует — добавляем (под используемый вами дистрибутив).

if cat /etc/apt/sources.list | grep  "backports" 
then echo "   Backports repository exists!"
else echo -e "   Adding Backports repository to sources.list: 
deb http://ru.archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse:\n" #adding the string
sudo sh -c "echo 'deb http://ru.archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse' >>  /etc/apt/sources.list" 
# deb-src http://ru.archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse
fi

#2.Обновление пакетного менеджера.
echo -e '\n   Updating packet manager:\n'
sudo sh -c "apt update" #Обновление кэша пакетов
echo -e '\n   Upgrading the system:\n'
sudo sh -c "apt upgrade"  #Обновление системы (без возможности удаления пакетов)

#3.Установка и запуск Apache2.
echo -e '\n   Installing and running Apache2:\n'
sudo apt install --reinstall apache2
sudo ufw allow 'Apache'    #разрешить трафик на порту 80.
sudo systemctl restart apache2

#4.Установка Python.
echo -e '\n   Installing Python3:\n'
sudo apt install python3


#5.Установка и поднятие SSH-сервера.
echo -e '\n   Installing SSH-сервер:\n'
sudo apt install ssh
sudo systemctl restart ssh

#Cкрипт должен содержать минимум 10 действий, включая указанные выше. 
#К 5 обязательным действиям добавьте ещё 5 на ваше усмотрение.

#6.Вывод на экран списка установленных пакетов
echo -e '\n   The List of Installed packages:\n'
apt list

#7.Определение моего внешнего адреса
echo -e '\n   My External IP address is:'
curl -s icanhazip.com

#8.Установка службы времени ntpdate
echo -e '\n   Installing ntpdate service:\n'
sudo apt install ntpdate
echo -e '\n   Additional info on NTP service:\n'
sudo ntpq -p

#9.Пересоздание старницы по умолчанию
sudo sh -c 'rm /var/www/html/index.html'
#sudo sh -c 'curl -s wttr.in/Moscow  >>  /var/www/html/index.html' 
sudo sh -c 'touch /var/www/html/index.html'

#10.Вывод на страницу сайта прогноза погоды
#sed "s/SERVICESETSTATUS/$(serviceset show status)/" /var/www/html/index.html
echo -e '\n   Creating Moscow Weather prognisis: check "localhost" URL in your browser:\n'
sudo sh -c 'cat > /var/www/html/index.html' << EOF
<!DOCTYPE html>
<html>
    <head>
        <title>MSK 4Days Weather</title>
    </head>
    <body>
        <p>The Weather in Moscow will be:
		 `curl -s wttr.in/Moscow`!</p>
    </body>
</html>
EOF



