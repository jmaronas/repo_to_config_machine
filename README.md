# Repository to configure machines

This repository has some useful scripts I modify and use to set up my personal new machines. For example it sets up my vim color my gitignore, it install some packages I always use.

I dont pretend to put too much details here. If you are interested in knowing how this work feel free to shot an email and I will explain how I have organized stuff

The scripts provided here are thought to be used for your personal machine where you have root access. However, part of these scripts are also useful if, for example, you are given access to some other machine via ssh where you are planning to use conda or vim. It should be relatively easy to adapt the scripts provided in this repo to make set ups in other machines. I already provide some of this done. For example install.sh requires to be sudo since it install things from apt-get. Simpler_install.sh only install conda without the sudo command. Same with simpler_config.sh that only sets up vim and git. Normal install.sh is likely to be used in your personal machine while simpler_install.sh could be used in a machine you have gained access to but you dont have permissions. 
