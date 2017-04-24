# Custom TinyCore Linux

Two tiny scripts to

  1. Extract a tinycore linux ISO to `iso` and `core` directories
  2. Repack them back to a single ISO

## Usage Example

```
$ ./tinycore-extract.sh CorePure64-8.0.iso
$ git clone https://github.com/tycho/cpuid.git
$ cd cpuid
$ echo 'LDFLAGS += -static' >> GNUmakefile
$ make
$ cd ..
$ # print CPUID on login
$ fakeroot cp cpuid/cpuid core/usr/bin
$ fakeroot bash -c 'echo cpuid -c0 >core/etc/profile.d/cpuid.sh'
$ # do not prompt to boot
$ sed -i.orig /prompt/d iso/boot/isolinux/isolinux.cfg
$ ./tinycore-repack.sh cpuid.iso
$ kvm -cdrom cpuid.iso
```
