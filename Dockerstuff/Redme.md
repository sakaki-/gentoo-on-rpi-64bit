[![Docker Repository on Quay](https://quay.io/repository/necrose99/gentoo-on-rpi3-64bit/status "Docker Repository on Quay")](https://quay.io/repository/necrose99/gentoo-on-rpi3-64bit)
 **The Image is quite highly experamental works on rpi but Docker is not a known Certianty.** 
 Likely BPI Rock64 with some mods for video card etc , uboot , however most of @sakaki- 's packages should work. 
 I'd go read up on docker fortuantly much better is online than I have. 
 
###also you could run over Scaleaway hosting , as they have debian or centos ubutu root fs's .  and run the builder in docker for custom packing. 

https://github.com/scaleway/docker-machine-driver-scaleway  can run this directly on thier Arm64 machines.. 

https://github.com/scaleway/image-tools  can likely also create own Gentoo apps from docker images also.. 
 
 *I'm still learning about Docker , its kinda trial and Error , but call it an exapmle..*  of which you can template and hopefully pull and improve , and #1 hell for me to fix has been **QEMU-arm64-static** to run on on boxes w/o **QEMU installed**  
 
 **FROM quay.io/necrose99/gentoo-on-rpi3-64bit  in your own Dockerfile** , and you can **"Fork"** a prebuild image add or remove stuff as you like then pull down or use in dockercompose.. 
 
docker pull quay.io/necrose99/gentoo-on-rpi3-64bit  
** You will Need qemu on your host 
https://github.com/multiarch/qemu-user-static/blob/master/register/qemu-binfmt-conf.sh /  added to this image 


https://hub.docker.com/r/necrose99/gentoo-on-rpi3-64bit/builds/

**For Full Documentation SEE**
https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/README.md for the
Image.

\#\#\# TO DO FIX THE F'ing QEMU.... and BINFMT ala debian source, or
https://gpo.zugaina.org/app-emulation/qemu-arm-wrappers

https://gpo.zugaina.org/app-emulation/qemu-charm

https://gpo.zugaina.org/app-emulation/qemu-user

https://gpo.zugaina.org app-emulation/qemu-initscript or
app-emulation/qemu-init-script for guest. in this ie the SAKAKI-RPI3 container.
services for AMD-64 so you can use as a re-windable CHROOT for PYPY/PYPY3 GHC or
other PIG Packages some will compile spkie the ram needs then die... PYPY wants
2 gigs+ (might have to format usb to swap....\@ 16ish gigs) also I killed my RPI3 by trying to swap to systemd


next rub is the gentoo emulation. however the docker container builds just toook
a crap ton of time to upload a FS dump to dropbox and yank into quay.io.

https://hub.docker.com/r/necrose99/gentoo-on-rpi3-64bit/builds/

\@ <https://github.com/sakaki-/gentoo-on-rpi3-64bit>

<https://www.dropbox.com/home/sakaki--gentoo-on-rpi3-64bit/packages-rpi3-arm64>  bit stale will need recompiled since new PIE.
however some dev-ops tools like puppet might be in this image repo https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-ruby/puppetdb-termini/puppetdb-termini-4.3.0.ebuild?id=af6d76ca869354837eab5968c01da73364be99df  is packaged however liekly stale ... 

**\@Necrose99’s mini repo… , if you have dropbox and 16 gigs+ it would be wise
to just take the whole thing**
[packages](https://www.dropbox.com/home/sakaki--gentoo-on-rpi3-64bit?preview=Packages.txt)
note may change over time as I upload more or get a WEB Mirror .org to do
propper mirroring.
                                                                                                                                                                                                                                                            


