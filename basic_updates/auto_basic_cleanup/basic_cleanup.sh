#!/bin/sh

#To clean partial packages
sudo apt-get autoclean
#To cleanup the apt cache
sudo apt-get clean
#To remove the unused packages
sudo apt-get autoremove
#Swap memory cleanup
sudo swapoff -a
sudo swapon -a