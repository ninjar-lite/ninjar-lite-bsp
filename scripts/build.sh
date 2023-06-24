#!/bin/bash

if [ -z "$BASH" ]; then echo "Please run this script $0 with bash"; exit 1; fi

source ./scripts/utils.sh || echo "failed to setup shell utils"
source ./scripts/envsetup.sh || echo "failed to setup env"
source ./scripts/get_toolchain.sh || echo "failed to setup toolchain"

############### WORKFLOW #######################
# $1 string: path to be check
# $2 string: name
function do_check() {
	if [ -d $1 ]; then
		echo_debug "$2 exists"
		return $OK
	else
		echo_warn "$2 non exists"
		return $ERR
	fi
}

# $1 bool:   if or not
# $2 string: thing going to be download
function do_fetch() {
	if [ $1 -eq $ERR ]; then
		echo_debug "will fetch $2"
		$SCRIPTS_DIR/get_things.sh $2
	else
		echo_debug "skip the fetch flow"
	fi
}

# TODO: if we have the need to patch something, do it right here.
function do_patch() {
	echo_debug "do_patch workflow"
}

# common build flow
# $1 string: path of prompt
# $2 string: name of prompt
function do_build() {
	echo_love "looks someone want to build the $2. so let him be."
	do_check $1 $2
	do_fetch $? $2
}

function do_build_uboot() {
	do_build $UBOOT_DIR uboot
}

function do_build_kernel() {
	do_build $KERNEL_DIR kernel
}

function do_build_buildroot() {
	do_build $BUILDROOT_DIR buildroot
}

function do_build_all() {
	do_build_uboot
	do_build_kernel
	do_build_buildroot
}

#############################################

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
	do_build_all
        ;;

    "uboot")
        do_build_uboot
        ;;
    
    "kernel")
	do_build_kernel
        ;;
    
    "buildroot")
	do_build_buildroot
        ;;
esac

if [ "$#" == "0" ]; then
    echo_debug "by default, build all thing"
    do_build_all
else
    echo_love "as you wish."
fi
