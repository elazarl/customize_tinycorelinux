#!/bin/bash

set -e

die() {
	echo $@
	exit 1
}

ISO="$1"
if [ -z "$ISO" ]; then
	ISO=CorePure64-current.iso
	if [ ! -f "$ISO" ]; then
		echo 'No ISO file specified. Download latest ISO v8.x? [yn]'
		read opt
		[ "$opt" == y ] || die Usage: $0 '[tinycore.iso]'
		wget http://www.tinycorelinux.net/8.x/x86_64/release/CorePure64-current.iso
	fi
fi

# create all directories
rm -rf iso
isoinfo -l -R -J -i "$ISO" | sed -n 's/Directory listing of //p'|xargs -I_ mkdir -p iso/_
isoinfo -f -R -J -i "$ISO" | while read f; do
	[ ! -d "iso$f" ] && isoinfo -R -J -x "$f" -i "$ISO" >iso$f
done
rm -rf core
mkdir -p core
zcat iso/boot/core*.gz | (cd core; fakeroot cpio -i -H newc -d)

