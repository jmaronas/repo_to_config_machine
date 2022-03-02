#!/bin/bash

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

# Copy .vimrc into ~
cp ./config_files/.vimrc $HOME

# Copy .gitconfig into ~
cp ./config_files/.gitconfig $HOME

## Modify bash_rc
echo "==== Modifying .bashrc"
cat ./config_files/changes_to_bash_rc.sh >> $HOME/.bashrc
