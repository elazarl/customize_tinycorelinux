#!/bin/bash

set -e

die() {
	echo $@
	exit 1
}

ISO="$1"
if [ -z "$ISO" ]; then
	echo 'No output ISO file specified. Use default name tinycore.iso? [y]'
	read opt
	[ "$opt" == y ] || die Usage: $0 '[tinycore.iso]'
	ISO=tinycore.iso
fi

(
cd core
find | fakeroot cpio -o -H newc | gzip -2 > tmpcoregz && fakeroot mv tmpcoregz ../iso/boot/core*.gz
)

genisoimage -l -J -R -V tinycore-$USER-$DATE \
	-input-charset utf-8 \
	-no-emul-boot -boot-load-size 4 -boot-info-table \
	-b boot/isolinux/isolinux.bin -c boot/isolinux/boot.cat \
	-o $ISO iso
