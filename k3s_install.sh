#!/bin/bash
sestatus
read -p "Continue? " ANSWER
if [ "$ANSWER" != y ]; then
    exit 1
else
    echo "Stopping and disabling firewall"
    systemctl stop firewalld >/dev/null
    systemctl disable firewalld >/dev/null
    echo "Installing tools"
    if
        ! yum install epel-release -y >/dev/null
    then
        echo "Script stopped trying to yum install"
        exit 1
    else
        if
            ! yum install net-tools traceroute epel-release redis telnet haproxy netcat expect yum-utils rsync htop -y >/dev/null
        then
            echo "Script stopped trying to yum install"
        else
            echo "Tools yum installed"
        fi
    fi
    echo "Enter database server:"
    read -r DB_SERVER
    echo "Enter database user:"
    read -r DB_USER
    echo "Enter database password:"
    read -r DB_PASSWORD
    echo -e "\nInstalling k3s now"
    curl -skfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.20.15+k3s1" sh -s - server --datastore-endpoint="mysql://${DB_USER}:${DB_PASSWORD}@tcp(${DB_SERVER}:3306)/k3s"
    echo "Installation completed"
    if ! systemctl status k3s >/dev/null; then
        echo "k3s not running, exiting"
        exit 1
    else
        echo "k3s started Successfully"
        #tar -xzf fcYaml.tgz
        #cd yaml || exit
        #mv .vimrc ~/.vimrc
        #sh apply.sh
    fi
fi

