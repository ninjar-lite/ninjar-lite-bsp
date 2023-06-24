#!/bin/bash

export RED_COLOR='\E[1;31m'
export GREEN_COLOR='\E[1;32m'
export YELOW_COLOR='\E[1;33m'
export BLUE_COLOR='\E[1;34m'
export PINK_COLOR='\E[1;35m'
export RES='\E[0m'

function echo_error() {
    echo -e "[ $(date +"%H:%M:%S") ]: ${RED_COLOR} $1 ${RES}"
}
export -f echo_error

function echo_warn() {
    echo -e "[ $(date +"%H:%M:%S") ]: ${YELOW_COLOR} $1 ${RES}"
}
export -f echo_warn 

function echo_debug() {
    echo -e "[ $(date +"%H:%M:%S") ]: ${BLUE_COLOR} $1 ${RES}"
}
export -f echo_debug

function echo_success() {
    echo -e "[ $(date +"%H:%M:%S") ]: ${GREEN_COLOR} $1 ${RES}"
}
export -f echo_success

function echo_love() {
    echo -e "[ $(date +"%H:%M:%S") ]: ${PINK_COLOR} $1 ${RES}"
}
export -f echo_love

function check_shell() {
    if [ -z "$BASH" ]; then echo "Please run this script $0 with bash"; exit; fi
}
export -f check_shell

function check_runner() {
    if [ "$whoami" != "root" ] || [ "$UID" != "1000" ]; then echo "Please run this script $0 with root access"; exit 1; fi
}
export -f check_runner

function croot() {
	cd $WORKDIR
}
export -f croot

function cboot() {
	cd $UBOOT_DIR || echo_warn "maybe you should fetch it first."
        $SCRIPTS_DIR/get_things.sh
}
export -f cboot

function ckernel() {
	cd $KERNEL_DIR || echo_warn "maybe you should fetch it first."
}

# install requirements

# only support debian like for now
