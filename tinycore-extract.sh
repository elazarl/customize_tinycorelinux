#!/bin/bash

set -e

die() {
	echo $@
	exit 1
}

[ -n "$1" ] || die usage: $0 core.iso

# create all directories
rm -rf iso
isoinfo -l -R -J -i "$1" | sed -n 's/Directory listing of //p'|xargs -I_ mkdir -p iso/_
isoinfo -f -R -J -i "$1" | while read f; do
	[ ! -d "iso$f" ] && isoinfo -R -J -x "$f" -i "$1" >iso$f
done
rm -rf core
mkdir -p core
zcat iso/boot/core*.gz | (cd core; fakeroot cpio -i -H newc -d)

