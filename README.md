# Custom TinyCore Linux

Two tiny scripts to

  1. Extract a tinycore linux ISO to `iso` and `core` directories
  2. Repack them back to a single ISO

## Usage Example

```
$ ./tinycore-extract.sh
No ISO file specified. Download latest ISO v8.x? [yn]
y
--2017-04-26 08:54:01--  http://www.tinycorelinux.net/8.x/x86_64/release/CorePure64-current.iso
Resolving www.tinycorelinux.net (www.tinycorelinux.net)... 89.22.99.37
Connecting to www.tinycorelinux.net (www.tinycorelinux.net)|89.22.99.37|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 13225984 (13M) [application/octet-stream]
Saving to: ‘CorePure64-current.iso’

CorePure64-current.iso                             100%[================================================================================================================>]  12.61M  3.79MB/s    in 3.3s    

2017-04-26 08:54:04 (3.79 MB/s) - ‘CorePure64-current.iso’ saved [13225984/13225984]

25478 blocks
$ fakeroot cp `which cpuid` core/usr/bin
$ ln -s /lib core/lib64 # Ubuntu software excepts libs in /lib64
$ # run cpuid on login
$ fakeroot bash -c 'echo cpuid -c0 >core/etc/profile.d/cpuid.sh'
$ # do not prompt to boot
$ sed -i.orig /prompt/d iso/boot/isolinux/isolinux.cfg
$ ./tinycore-repack.sh
No output ISO file specified. Use default name tinycore.iso? [y]
y
cpio: File ./tmpcoregz grew, 7995392 new bytes not copied
41255 blocks
Size of boot image is 4 sectors -> No emulation
 47.37% done, estimate finish Wed Apr 26 10:48:44 2017
 94.71% done, estimate finish Wed Apr 26 10:48:44 2017
Total translation table size: 2048
Total rockridge attributes bytes: 0
Total directory bytes: 4202
Path table size(bytes): 38
Max brk space used 22000
10573 extents written (20 MB)
$ kvm -cdrom tinycore.iso
```
