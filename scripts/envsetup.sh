#!/bin/bash

PROJECT_NAME="ninjar-lite-bsp"

WORKDIR="$(pwd)"
BUILD_DIR="$WORKDIR/build"
SCRIPTS_DIR="$WORKDIR/scripts"
UBOOT_DIR="$WORKDIR/u-boot"
KERNEL_DIR="$WORKDIR/kernel"
BUILDROOT_DIR="$WORKDIR/buildroot"
TOOLCHAIN_DIR="$WORKDIR/toolchain"
TOOLCHAIN_INSTALL_DIR="/opt"

NCPU=$(grep -c processor /proc/cpuinfo)

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