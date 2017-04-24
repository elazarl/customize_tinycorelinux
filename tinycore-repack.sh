#!/bin/bash

set -e

die() {
	echo $@
	exit 1
}

[ -n "$1" ] || die usage: $0 result.iso

(
cd core
find | fakeroot cpio -o -H newc | gzip -2 > tmpcoregz && fakeroot mv tmpcoregz ../iso/boot/core*.gz
)

genisoimage -l -J -R -V tinycore-$USER-$DATE \
	-input-charset utf-8 \
	-no-emul-boot -boot-load-size 4 -boot-info-table \
	-b boot/isolinux/isolinux.bin -c boot/isolinux/boot.cat \
	-o $1 iso
