FROM scratch
MAINTAINER sakaki & Necrose99
ENV QEMU_EXECVE 1
ENV QEMU_CPU aarch64
ENV ARCH=arm64
# Define standard volumes
VOLUME ["/usr/portage", "/usr/portage/distfiles", "/usr/portage/packages", "/var/lib/entropy/client/packages"]
# VOLUME /var/lib/entropy/client/packages:rw # not building Sabayon packages from gentoo at this time. 

### ADD Base Image for mnt Loop and load emulation etc.  AMD64 Busybox for utils in docker on amd64 hosts.. 
ADD https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-x86_64 /busybox/busybox
### ADD Base Image
# gentoo-on-rpi3-64bit
ADD https://www.dropbox.com/s/jptnzaf1fgr2k5d/sakaki--gentoo-rpi3-ARM64bit.tar.gz?dl=0   / 
## hotpatch docker make.conf bihost.
## Fix to new binhost. 
ADD https://www.dropbox.com/s/v1q0wjlxy62qrjl/pi-back.sh?dl=0  /etc/portage/make.conf 

ADD https://www.dropbox.com/s/v1q0wjlxy62qrjl/pi-back.sh?dl=0  /pi-back.sh 
## backup toy tarball root-fs-backup minus swapfile 
## 
ADD https://pastebin.com/dl/sJArLT8x  /ebuildr
## ebuildr  useful over shh nohup ./ebuildr > /dev/null 2>&1 &  emerges binpkgs only after grep also useful if you've broken genup.. 
## forget were i filched it off ... but so dambed handy if ssh crashes also useful for arm64 hosting @ Scaleaway /rpi-64-chroot 
## as SSH can die..  however very no frills nohup background emerge ... etc.. 
## 
# RUN /busybox/busybox mv -R /mnt/stick/* / fix tarball image
# /boot volume , I extracted to /tmp/boot packed as /boot should dump to /boot/*
# add root volume extracted from DD image > usb > root-fs.tar.xz 
# hashes https://www.dropbox.com/s/3760agnp0vvs99q/sakaki--gentoo-on-rpi3-64bit.sha3-512?dl=0 /
# ADD hashes. 
# too DO loop mount images in future @ mnt boot root and @ > / rsync etc. as upsteam autogen's... 
# ADD https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.2.1/genpi64.img.xz /mnt
#/mnt/
## At present its a DD image and not a tar-snapshot. 
#run -it --rm --privileged -vlosetup -fP --show /mnt/genpi64.img  /dev/loop0
#  run -it --rm --privileged -v mount -o loop,offset=$((137216*512))  /mnt/genpi64.img 
#mount /dev/loop0p1 /mnt
#mount /dev/loop0p2 /mnt
# rsync -aAXv /path/to/backup/location/* /mount/point/of/new/install/ --exclude={/mnt/*}
## add volumes for building packages , etc.
ADD https://raw.githubusercontent.com/necrose99/Arm64-Linux-prep/master/prep/etc/resolv.conf_  /etc/resolv.conf
# use google DNS for Resovler. 

ADD https://github.com/multiarch/qemu-user-static/blob/master/register/qemu-binfmt-conf.sh / 

# try and register fmt in system busybox-x86_64 so can run native... or cloud host :-)
 
 ## Add emulation Binaries for AMD64 host. 
ADD https://github.com/multiarch/qemu-user-static/releases/download/v2.11.1/qemu-aarch64-static.tar.gz /usr/bin/qemu-aarch64-static

#updated qemu static 

#ENTRYPOINT [/busybox/busybox "/usr/bin/qemu-aarch64-static", "-execve", "-0", "bash", "/bin/bash"]
# test case CMD /busybox/busybox /usr/bin/qemu-aarch64-static  -execve-0  /bin/bash
#RUN  /usr/bin/qemu-aarch64-static  -execve-0 /bin/bash ./qemu-binfmt-conf.sh 
#CMD /busybox/busybox /usr/bin/qemu-aarch64-static  -execve-0  /bin/bash

# test 
## pray ::: might actually get to rig in quay.io/hubdocker. 
#
## RUN emerge-webrsync && && layman -S && emerge -uDUG --keep-going --with-bdeps=y @world --binpkg-respect-use=y 
## G getpkgonly freshen image from new binhost.. 
#else RUN /busybox/busybox /usr/bin/qemu-aarch64-static  -execve-0 emerge-webrsync && && layman -S && emerge -uDUG --keep-going --with-bdeps=y @world

### gentoo docker bits likely old and no loger neded will clean on confirm... 
# Setup the rc_sys  # fix emulation then let this by.  
#RUN /busybox/busybox sed -e 's/#rc_sys=""/rc_sys="docker"/g' -i /etc/rc.conf
# By default, UTC system
#RUN /busybox/busybox echo 'UTC' > /etc/timezone

## own likely stale ...... 
# ADD https://github.com/necrose99/Arm64-Linux-prep/blob/master/binfmt-support_2.1.6-2_arm64.tar?raw=true /
# /usr/sbin, update-binfmts < cat update-binfmts_amd update-binfmts_arm64 debian.

#ADD https://github.com/mickael-guene/umeq/releases/download/1.7.5/umeq-arm64 /usr/bin/umeq-arm64
#ADD https://github.com/mickael-guene/proot-static-build/raw/master/static/proot-x86_64 /usr/bin/proot-x86_64
# debugg
#RUN /usr/sbin/update-binfmts_arm64
## more than a number of ways to skin this cat. 


### with arm64 always a bit , make that frustratingly alot of tinkering, 
## can add DEBIAN BINFMT service , as it will add more transparent emulation. 
