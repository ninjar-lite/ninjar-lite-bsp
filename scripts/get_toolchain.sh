#!/bin/bash

TOOLCHAIN_FILE="gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi.tar.xz"
TOOLCHAIN_EXTRACT_NAME="gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi"
TOOLCHAIN_URL="http://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/arm-linux-gnueabi/$TOOLCHAIN_FILE"

if [ "$WORKDIR" == "" ]; then
    echo 'please run "source ./envsetup.sh" first'
    exit 1
fi

echo_debug "work dir is $WORKDIR"

echo_debug "downloading toolchain into '$TOOLCHAIN_DIR'"
mkdir -p "$TOOLCHAIN_DIR"

# download the toolchain
# TODO: if failed, we should attempt a mirror
if [ ! -e "$TOOLCHAIN_DIR/$TOOLCHAIN_FILE" ]; then
    wget "$TOOLCHAIN_URL" -O "$TOOLCHAIN_DIR/$TOOLCHAIN_FILE"
    cd "$WORKDIR" || echo ""
else
    echo_debug "toolchain has been downloaded at $TOOLCHAIN_DIR/$TOOLCHAIN_FILE"
fi

# extract toolchain into target dir
if [ ! -e "$TOOLCHAIN_INSTALL_DIR/$TOOLCHAIN_EXTRACT_NAME" ]; then
    echo_debug "extracting toolchain ..."
    sudo tar xJf "$TOOLCHAIN_DIR/$TOOLCHAIN_FILE" -C "$TOOLCHAIN_INSTALL_DIR"
else
    echo_success "toolchain has been extracted at $TOOLCHAIN_INSTALL_DIR/$TOOLCHAIN_EXTRACT_NAME"
fi

# setting up envs
ARCH=arm
CROSS_COMPILE=arm-linux-gnueabi-
PATH=$PATH:$TOOLCHAIN_INSTALL_DIR/$TOOLCHAIN_EXTRACT_NAME/bin

export ARCH
export CROSS_COMPILE
export PATH

# finally return to workdir
cd "$WORKDIR" || echo_error "can't change to $WORKDIR"
