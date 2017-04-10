FROM scratch
MAINTAINER sakaki & Necrose99
ENV ARCH=arm64
### ADD Base Image for mnt Loop and load emulation etc.  AMD64 Busybox for utils in docker on amd64 hosts.. 
ADD https://busybox.net/downloads/binaries/1.26.2-defconfig-multiarch/busybox-x86_64 /busybox/busybox
### ADD Base Image
# gentoo-on-rpi3-64bit
ADD https://www.dropbox.com/s/0f1nzj7yze870d6/boot.tar.xz?dl=0   / 
ADD https://www.dropbox.com/s/c8feto0h538wwdn/rootfs.tar.xz?dl=0 /
# /boot volume , I extracted to /tmp/boot packed as /boot should dump to /boot/*
# add root volume extracted from DD image > usb > root-fs.tar.xz 
# hashes https://www.dropbox.com/s/3760agnp0vvs99q/sakaki--gentoo-on-rpi3-64bit.sha3-512?dl=0 /
# ADD hashes. 
# too DO loop mount images in future @ mnt boot root and @ > / rsync etc. as upsteam autogen's... 
# ADD https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.0.2/genpi64.img.xz /mnt
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
VOLUME /var/lib/layman:rw, /usr/portage:rw", /usr/portage/distfiles:rw, /packages:rw, /:rw
# VOLUME /var/lib/entropy/client/packages:rw # not building Sabayon packages from gentoo. 
## Add emulation Binaries for AMD64 host. 
### with arm64 always a bit , make that frustratingly alot of tinkering, 
## can add DEBIAN BINFMT service , as it will add more transparent emulation. 
ADD https://github.com/necrose99/Arm64-Linux-prep/blob/master/binfmt-support_2.1.6-2_arm64.tar?raw=true /
# /usr/sbin, update-binfmts < cat update-binfmts_amd update-binfmts_arm64 debian. 
ADD https://github.com/multiarch/qemu-user-static/releases/download/v2.8.1/x86_64_qemu-aarch64-static.tar.gz /usr/bin/qemu-aarch64-static
ADD https://github.com/mickael-guene/umeq/releases/download/1.7.5/umeq-arm64 /usr/bin/umeq-arm64
ADD https://github.com/mickael-guene/proot-static-build/raw/master/static/proot-x86_64 /usr/bin/proot-x86_64

## more than a number of ways to skin this cat. 
RUN /busybox/busybox ash  ./usr/sbin/update-binfmts
#ENTRYPOINT ["/usr/bin/umeq-arm64", "-execve", "-0", "bash", "/bin/bash"]
ENTRYPOINT ["/busybox/busybox ash ./usr/bin/qemu-aarch64-static", "-execve", "-0", "bash", "/bin/bash"]


# Setup the rc_sys  # fix emulation then let this by.  
RUN /busybox/busybox sed -e 's/#rc_sys=""/rc_sys="docker"/g' -i /etc/rc.conf
# By default, UTC system
RUN /busybox/busybox echo 'UTC' > /etc/timezone


