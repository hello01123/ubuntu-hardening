#!/bin/bash
# Copyright (c) 2015-2019 Ben Hall
# All rights reserved.
#
# Name: ubuntu-hardening
# Version: 3.0.1
# PLAT:  linux-64
# PLAT-Version: linux-14.04

chmod 755 scripts -R #ensure source can access modules

source scripts/apache.sh
source scripts/apt.sh
source scripts/audit.sh
source scripts/banners.sh
source scripts/cron.sh
source scripts/filemgt.sh
source scripts/hosts.sh
source scripts/malware.sh
source scripts/mysql.sh
source scripts/nginx.sh
source scripts/perm.sh
source scripts/php.sh
source scripts/postfix.sh
source scripts/process.sh
source scripts/pureftpd.sh
source scripts/purge.sh
source scripts/rkhunter.sh
source scripts/samba.sh
source scripts/ssh.sh
source scripts/sudo.sh
source scripts/sysctl.sh
source scripts/ufw.sh
source scripts/users.sh
source scripts/vsftpd.sh

clear
echo "Ubuntu Hardening Script v.1.0.3 for Ubuntu 14.04 and 16.04"
echo "Created by Ben Hall"
echo "Note: Designed for CyberPatriots! Any use within the CyberPatriots competition will disqualify you!"

version=$(lsb_release -a) 



read -p "Press any key to continue... " -n 1
echo

clear
read -p "Keep backup file of scoring report? (y/N) >> " -n 1 -r input_backup
echo

if [[ $input_backup =~ ^[Yy]$ ]]
then
    read -p "What is the location of the scoring report? (y/N) >> " -r backup_location
    echo
    crontab -e */5 * * * * cp -f $backup_location scoring_report.log
fi

clear
read -p "Configure/Install apt? (y/N) >> " -n 1 -r input_apt
echo
clear
read -p "Configure the firewall? (y/N) >> " -n 1 -r input_firewall
echo
clear
read -p "Configure user settings? (y/N) >> " -n 1 -r input_users
echo
if [[ $input_users =~ ^[Yy]$ ]]
then
    read -p "Input admins in README (seperate with spaces) >> " -r givenAdmins
    echo
    read -p "Input users in README (seperate with spaces) >> " -r givenUsers
    echo
    read -p "Input general password >>" -r passwd
    echo
fi
clear
read -p "Configure hosts file? (y/N) >> " -n 1 -r input_hosts
echo
clear
read -p "Delete media files? (y/N) >> " -n 1 -r input_files
echo
clear
read -p "Configure sysctl? (y/N) >> " -n 1 -r input_sysctl
echo
clear
read -p "Edit banners? (y/N) >> " -n 1 -r input_banners
echo
clear
read -p "Configure sudo? (y/N) >> " -n 1 -r input_sudo
echo
clear
read -p "Install and run rkhunter? (y/N) >> " -n 1 -r input_rkhunter
echo
clear
read -p "Harden processes? (y/N) >> " -n 1 -r input_processes
echo
clear
read -p "Configure permissions? (y/N) >> " -n 1 -r input_perm
echo
clear
read -p "Uninstall malicious software? (y/N) >> " -n 1 -r input_malware
echo
clear
read -p "Purge vulnerable software? (y/N) >> " -n 1 -r input_purge
echo
clear
read -p "Harden mysql databases? (y/N) >> " -n 1 -r input_mysql
echo
clear
read -p "Configure cron? (y/N) >> " -n 1 -r input_cron
echo
clear
read -p "Configure audit? (y/N) >> " -n 1 -r input_audit
echo
clear
read -p "Configure postfix? (y/N) >> " -n 1 -r input_postfix
echo
clear
read -p "Configure php? (y/N) >> " -n 1 -r input_php
echo
clear
read -p "Harden critical services? (y/N) >> " -n 1 -r input_services
echo
if [[ $input_services =~ ^[Yy]$ ]]
then
    read -p "Input critical services from README (seperate with spaces) >> " -r criticalServices
    echo
fi
clear

if [[ $criticalServices =~ .*ssh.* ]]
then
    echo "SSH is identified as a critical service and will not be uninstalled"
else
    if [[ $(apt-cache policy openssh-server) =~ .*"Installed: (none)".* ]]
    then
        echo "SSH is not currently installed and is not a critical service."
    else
        read -p "Remove ssh? (y/N) >> " -n 1 -r deletionConfirmation
        echo
        if [[ $deletionConfirmation =~ ^[Yy]$ ]]
        then
            apt-get purge openssh-server -y
            echo "SSH has been purged."
        fi
    fi
fi

echo

if [[ $criticalServices =~ .*vsftpd.* ]]
then
    echo "vsFTPd is identified as a critical service and will not be uninstalled"
else
    if [[ $(apt-cache policy vsftpd) =~ .*"Installed: (none)".* ]]
    then
        echo "vsFTPd is not currently installed and is not a critical service."
    else
        read -p "Remove vsftpd? (y/N) >> " -n 1 -r deletionConfirmation
        echo
        if [[ $deletionConfirmation =~ ^[Yy]$ ]]
        then
            apt-get purge vsftpd -y
            echo "vsFTPd has been purged."
        fi
    fi
fi

echo

if [[ $criticalServices =~ .*proftpd.* ]]
then
    echo "proFTPd is identified as a critical service and will not be uninstalled"
else
    if [[ $(apt-cache policy proftpd) =~ .*"Installed: (none)".* ]]
    then
        echo "proFTPd is not currently installed and is not a critical service."
    else
        read -p "Remove proFTPd? (y/N) >> " -n 1 -r deletionConfirmation
        echo
        if [[ $deletionConfirmation =~ ^[Yy]$ ]]
        then
            apt-get purge proftpd -y
            echo "proFTPd has been purged."
        fi
    fi
fi

echo

if [[ $criticalServices =~ .*samba.* ]]
then
    echo "Samba is identified as a critical service and will not be uninstalled"
else
    if [[ $(apt-cache policy samba) =~ .*"Installed: (none)".* ]]
    then
        echo "Samba is not currently installed and is not a critical service."
    else
        read -p "Remove samba? (y/N) >> " -n 1 -r deletionConfirmation
        echo
        if [[ $deletionConfirmation =~ ^[Yy]$ ]]
        then
            apt-get purge samba -y
            echo "Samba has been purged."
        fi
    fi
fi

echo

if [[ $criticalServices =~ .*nginx.* ]]
then
    echo "Nginx is identified as a critical service and will not be uninstalled"
else
    if [[ $(apt-cache policy nginx) =~ .*"Installed: (none)".* ]]
    then
        echo "Nginx is not currently installed and is not a critical service."
    else
        read -p "Remove nginx? (y/N) >> " -n 1 -r deletionConfirmation
        echo
        if [[ $deletionConfirmation =~ ^[Yy]$ ]]
        then
            apt-get purge nginx -y
            echo "Nginx has been purged."
        fi
    fi
fi

echo

if [[ $criticalServices =~ .*pureftpd.* ]]
then
    echo "pureftpd is identified as a critical service and will not be uninstalled"
else
    if [[ $(apt-cache policy pure-ftpd) =~ .*"Installed: (none)".* ]]
    then
        echo "pureftpd is not currently installed and is not a critical service."
    else
        read -p "Remove pureftpd? (y/N) >> " -n 1 -r deletionConfirmation
        echo
        if [[ $deletionConfirmation =~ ^[Yy]$ ]]
        then
            apt-get purge pure-ftpd -y
            echo "pureftpd has been purged."
        fi
    fi
fi

echo

if [[ $input_apt =~ ^[Yy]$ ]]
then
    echo "Configuring apt... "
    f_apt
    echo -e "[COMPLETE]"
fi

echo

if [[ $input_firewall =~ ^[Yy]$ ]]
then
    echo "Configuring ufw... "
    f_ufw
    echo "[COMPLETE]"
fi

echo

if [[ $input_users =~ ^[Yy]$ ]]
then
    echo "Configuring account settings... "
    f_users
    echo "[COMPLETE]"
fi

echo

if [[ $input_hosts =~ ^[Yy]$ ]]
then
    echo "Configuring hosts file... "
    f_hosts
    echo -e "[COMPLETE]"
fi

echo

if [[ $input_files =~ ^[Yy]$ ]]
then
    echo "Removing media files... "
    f_filemgt
    echo -e "[COMPLETE]"
fi

echo

if [[ $input_sysctl =~ ^[Yy]$ ]]
then
    echo "Configuring network settings... "
    f_sysctl
    echo -e "[COMPLETE]"
fi

echo

if [[ $input_banners =~ ^[Yy]$ ]]
then
    echo "Configuring banners... "
    f_banners
    echo "[COMPLETE]"
fi

echo

if [[ $input_sudo =~ ^[Yy]$ ]]
then
    echo "Configuring sudo... "
    f_sudo
    echo "[COMPLETE]"
fi

echo

if [[ $input_processes =~ ^[Yy]$ ]]
then
    echo "Hardening processes... "
    f_process
    echo "[COMPLETE]"
fi

echo

if [[ $input_rkhunter =~ ^[Yy]$ ]]
then
    echo "Installing and running rkhunter... "
    f_rkhunter
    echo "[COMPLETE]"
fi

echo

if [[ $input_perm =~ ^[Yy]$ ]]
then
    echo "Configuring permissions... "
    f_perm
    echo "[COMPLETE]"
fi

echo

if [[ $input_malware =~ ^[Yy]$ ]]
then
    echo "Removing potential malware... "
    f_malware
    echo "[COMPLETE]"
fi

echo

if [[ $input_purge =~ ^[Yy]$ ]]
then
    echo "Purging non-server applications... "
    f_purge
    echo "[COMPLETE]"
fi

echo

if [[ $input_postfix =~ ^[Yy]$ ]]
then
    echo "Configuring postfix... "
    f_postfix
    echo "[COMPLETE]"
fi

echo

if [[ $input_php =~ ^[Yy]$ ]]
then
    echo "Configuring apache2 php module... "
    f_php

    if [[ $version =~ .*14.04* ]]
    then
        sudo service apache2 stop
        sudo service apache2 start
    else
        if [[ $version =~ .*16.04* ]]
        then
            sudo systemctl enable apache2.service
            sudo systemctl reload-or-restart apache2.service
        fi
    fi

    echo "[COMPLETE]"

fi

echo

if [[ $input_mysql =~ ^[Yy]$ ]]
then
    echo "Configuring mysql databases... "
    f_mysql

    if [[ $version =~ .*14.04* ]]
    then
        sudo service mysql stop
        sudo service mysql start
    else
        if [[ $version =~ .*16.04* ]]
        then
            sudo systemctl enable mysql.service
            sudo systemctl reload-or-restart mysql.service
        fi
    fi

    echo "[COMPLETE]"

fi

echo

if [[ $CRITICALSERVICES =~ .*ssh.* ]]
then
    echo "Configuring ssh... "
    f_ssh

    if [[ $version =~ .*14.04* ]]
    then
        sudo service ssh stop
        sudo service ssh start
    else
        if [[ $version =~ .*16.04* ]]
        then
            sudo systemctl enable ssh.service
            sudo systemctl reload-or-restart ssh.service
            sudo systemctl enable sshd.service
            sudo systemctl reload-or-restart sshd.service
        fi
    fi

    echo "[COMPLETE]"
    
fi

echo

if [[ $CRITICALSERVICES =~ .*vsftpd.* ]]
then
    echo "Configuring vsftpd... "
    f_vsftpd

    if [[ $version =~ .*14.04* ]]
    then
        sudo service vsftpd stop
        sudo service vsftpd start
    else
        if [[ $version =~ .*16.04* ]]
        then
            sudo systemctl enable vsftpd.service
            sudo systemctl reload-or-restart vsftpd.service
        fi
    fi

    echo " [COMPLETE]"
fi

echo

if [[ $CRITICALSERVICES =~ .*nginx.* ]]
then
    echo "Configuring nginx... "
    f_nginx

    if [[ $version =~ .*14.04* ]]
    then
        sudo service nginx stop
        sudo service nginx start
    else
        if [[ $version =~ .*16.04* ]]
        then
            sudo systemctl enable nginx.service
            sudo systemctl reload-or-restart nginx.service
        fi
    fi

    echo "[COMPLETE]"
fi

echo

if [[ $CRITICALSERVICES =~ .*samba.* ]]
then
    echo "Configuring samba... "
    f_samba

    if [[ $version =~ .*14.04* ]]
    then
        sudo service samba stop
        sudo service samba start
    else
        if [[ $version =~ .*16.04* ]]
        then
            sudo systemctl enable samba.service
            sudo systemctl reload-or-restart samba.service
        fi
    fi

    echo "[COMPLETE]"
fi

if [[ $CRITICALSERVICES =~ .*pureftpd.* ]]
then
    echo "Configuring pureftpd... "
    f_pureftpd

    if [[ $version =~ .*14.04* ]]
    then
        sudo service pure-ftpd stop
        sudo service pure-ftpd start
    else
        if [[ $version =~ .*16.04* ]]
        then
            sudo systemctl enable pure-ftpd.service
            sudo systemctl reload-or-restart pure-ftpd.service
        fi
    fi

    echo "[COMPLETE]"
fi

if [[ $input_cron =~ ^[Yy]$ ]]
then
    echo "Configuring cron... "
    f_cron
    echo "[COMPLETE]"
fi

if [[ $input_audit =~ ^[Yy]$ ]]
then
    echo "Configuring audit... "
    f_audit
    echo "[COMPLETE]"
fi

echo "Ubuntu Hardening Script finished!"
echo "Press any button to exit."
echo
