FROM scratch
MAINTAINER sakaki & Necrose99
ENV ARCH=arm64
### ADD Base Image
# gentoo-on-rpi3-64bit
ADD https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.0.2/genpi64.img.xz /
#/mnt/
## At present its a DD image and not a tar-snapshot. 
#run -it --rm --privileged -vlosetup -fP --show /mnt/genpi64.img  /dev/loop0
#  run -it --rm --privileged -v mount -o loop,offset=$((137216*512))  /mnt/genpi64.img 
#mount /dev/loop0p1 /mnt
#mount /dev/loop0p2 /mnt
# rsync -aAXv /path/to/backup/location/* /mount/point/of/new/install/ --exclude={/mnt/*}
## add volumes for building packages , etc.
VOLUME /var/lib/layman:rw, /usr/portage:rw", /usr/portage/distfiles:rw, /packages:rw, /:rw
VOLUME /var/lib/entropy/client/packages:rw
## Add emulation Binaries for AMD64 host. 
### with arm64 always a bit , make that frustratingly alot of tinkering, 
## can add DEBIAN BINFMT service , as it will add more transparent emulation. 
ADD https://github.com/multiarch/qemu-user-static/releases/download/v2.8.1/x86_64_qemu-aarch64-static.tar.gz /usr/bin/qemu-aarch64-static
ADD https://github.com/mickael-guene/umeq/releases/download/1.7.5/umeq-arm64 /usr/bin/umeq-arm64
ADD https://github.com/mickael-guene/proot-static-build/raw/master/static/proot-x86_64 /usr/bin/proot-x86_64


## more than a number of ways to skin this cat. 
# ENTRYPOINT ["./umeq-arm64", "-execve", "-0", "bash", "/bin/bash"]
# ENTRYPOINT ["/usr/bin/qemu-aarch64-static", "-execve", "-0", "bash", "/bin/bash"]
