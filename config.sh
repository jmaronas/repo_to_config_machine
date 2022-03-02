#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ $# -eq 0 ]
then
    echo "Error!!! -> Specify conda path in argv1. Example: ./config.sh /usr/local/anaconda3/"
fi

conda_path=$1

## Set conda environments path for all my systems on the same folder
echo "==== Setting up environment conda path ===="
$conda_path"/bin/conda" config --add envs_dirs ~/.conda/envs

if [ "$?" -eq "1" ]; then
    echo "Setting conda path failed"
    exit 1
fi

## Copying config files
echo "==== Copying config files to destination path including: .vimrc .gitconfig ===="7
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

# Copy .vimrc into ~
cp ./config_files/.vimrc $USER_HOME

# Copy .gitconfig into ~
cp ./config_files/.gitconfig $USER_HOME

## Modify bash_rc
echo "==== Modifying .bashrc"
cat ./config_files/changes_to_bash_rc.sh >> $USER_HOME/.bashrc

## ===================================================================
## ======= Adding config stuff that is private such as aliases with IP
cd /tmp/
echo "==== Cloning repository where your private stuff is. Need, obviously a password and user name for cloning"

git-force-clone https://github.com/jmaronas/private_repo_to_config_machine.git /tmp/private_repo_to_config_machine/

if [ "$?" -eq "1" ]; then
    echo "Problem cloning private github repo."
    exit 1
fi

cd -

echo "==== Modifying .bashrc with private stuff"
cat /tmp/private_repo_to_config_machine/changes_to_bash_rc.sh >> $USER_HOME/.bashrc

echo "==== Setting up configuration for ssh"
/tmp/private_repo_to_config_machine/set_up_ssh.sh

if [ "$?" -eq "1" ]; then
    echo "Problem running ssh set up"
    exit 1
fi



