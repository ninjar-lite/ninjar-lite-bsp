#!/bin/bash

if [ -z "$BASH" ]; then echo "Please run this script $0 with bash"; exit 1; fi

source ./scripts/utils.sh || echo "failed to setup shell utils"
source ./scripts/envsetup.sh || echo "failed to setup env"

source ./scripts/get_toolchain.sh || echo "failed to setup toolchain"

function do_banner() {
cat << "EOF"  >> /dev/tty
 _   _ ___ _   _     _   _    ____  
| \ | |_ _| \ | |   | | / \  |  _ \ 
|  \| || ||  \| |_  | |/ _ \ | |_) |
| |\  || || |\  | |_| / ___ \|  _ < 
|_| \_|___|_| \_|\___/_/   \_\_| \_\
                                    
EOF
}
do_banner

function do_usage() {
cat << "EOF" >> /dev/tty
    ./build.sh <-h|uboot|kernel|buildroot> [param]

    -h      show this help page
EOF
}

PROMPT=""
case $1 in

    "-h")
        do_usage
        exit 0
        ;;

    "all")
        exit 0
        ;;

    "uboot")
        exit 0
        ;;
    
    "kernel")
        exit 0
        ;;
    
    "buildroot")
        exit 0
        ;;
esac

if [ "$#" == "0" ]; then
    echo_debug "by default, build all thing"
fi
