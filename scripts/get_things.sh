#!/bin/bash

check_shell || echo "please setup project first."

function do_fetch_thing() {
	echo_debug "fetching from $1"
}

function do_fetch_uboot() {
	echo_debug "fetching uboot ..."
	do_fetch_thing ${UBOOT_URL}
}

function do_fetch_kernel() {
	echo_debug "fetching kernel ..."
	do_fetch_thing ${KERNEL_URL}
}

function do_fetch_buildroot() {
	echo_debug "fetching buildroot ..."
	do_fetch_thing ${BUILDROOT_URL}
}

function do_usage() {
	echo_warn "Usage: $0 <uboot|kernel|buildroot|toolchain> [dest_dir]"
	echo_warn "\t\tthe default dest_dir was setupped in envsetup.sh"
	echo_warn "\texample:"
	echo_warn "\t\t $0 uboot"
}

case $1 in

    "-h")
        do_usage
        exit $?
        ;;

    "uboot")
	do_fetch_uboot
        exit $?
        ;;

    "kernel")
	do_fetch_kernel
        exit $?
        ;;

    "buildroot")
	do_fetch_buildroot
        exit $?
        ;;

    *)
        do_usage
	exit $?
	;;
esac

exit $?
