#!/bin/sh

set -u
set -e

BOARD_DIR=$(dirname "$0")

# https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/

mkdir -p $TARGET_DIR/etc/systemd/network
ln -sf /dev/null $TARGET_DIR/etc/systemd/network/99-default.link

# https://www.freedesktop.org/software/systemd/man/systemd-getty-generator.html

mkdir -p $TARGET_DIR/etc/systemd/system/getty.target.wants
ln -sf /lib/systemd/system/getty@.service $TARGET_DIR/etc/systemd/system/getty.target.wants/getty@tty1.service

# can't use pivot_root when running on rootfs, only when root is on e.g. tmpfs

mkdir -p $TARGET_DIR/etc/default
echo "export DOCKER_RAMDISK=true" > $TARGET_DIR/etc/default/dockerd
