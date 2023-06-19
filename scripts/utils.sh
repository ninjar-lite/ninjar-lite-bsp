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

# install requirements

# only support debian like for now