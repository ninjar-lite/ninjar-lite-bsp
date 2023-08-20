#!/usr/bin/env bash

PROJECT_NAME="ninjar-lite-bsp"

WORKDIR="$(pwd)"
BUILD_DIR="$WORKDIR/out"
SCRIPTS_DIR="$WORKDIR/scripts"
UBOOT_DIR="$WORKDIR/u-boot"
KERNEL_DIR="$WORKDIR/kernel"
BUILDROOT_DIR="$WORKDIR/buildroot"

# Toolchain
TOOLCHAIN_DIR="$WORKDIR/toolchain"
TOOLCHAIN_FILE="gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi.tar.xz"
TOOLCHAIN_EXTRACT_NAME="gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi"
TOOLCHAIN_URL="http://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/arm-linux-gnueabi/$TOOLCHAIN_FILE"
TOOLCHAIN_INSTALL_DIR="/opt"

NCPU=$(grep -c processor /proc/cpuinfo)

OK=0
ERR=1

REMOTE=ninjar-bsp
UPSTREAM_URL=https://github.com/${REMOTE}

UBOOT_URL=${UPSTREAM_URL}/u-boot
KERNEL_URL=${UPSTREAM_URL}/linux
BUILDROOT_URL=${UPSTREAM_URL}/buildroot

# setting up envs
ARCH=arm
CROSS_COMPILE=arm-linux-gnueabi-
PATH=$PATH:$TOOLCHAIN_INSTALL_DIR/$TOOLCHAIN_EXTRACT_NAME/bin

export ARCH
export CROSS_COMPILE
export PATH

# variables, functions exporting
export PROJECT_NAME
export WORKDIR
export BUILD_DIR
export SCRIPTS_DIR
export UBOOT_DIR
export KERNEL_DIR
export BUILDROOT_DIR
export TOOLCHAIN_DIR
export TOOLCHAIN_INSTALL_DIR

export NCPU
export OK
export ERR

export REMOTE
export UPSTREAM_URL
export UBOOT_URL
export KERNEL_URL
export BUILDROOT_URL
