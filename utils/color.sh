#!/bin/bash
# color echo
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}

yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}

blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}

bold(){
    echo -e "\033[1m\033[01m$1\033[0m"
}
