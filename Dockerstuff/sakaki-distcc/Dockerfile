FROM gentoo/stage3-amd64 
 
## Icecream its often easier.  howver for now not that many to build on. 
## USE Zeroconf to make it stupidly EASY... 
############################################################
ADD https://raw.githubusercontent.com/necrose99/gentoo-on-rpi3-64bit/master/Dockerstuff/sakaki-distcc/entrypoint.sh /entrypoint.sh
ADD https://raw.githubusercontent.com/necrose99/gentoo-on-rpi3-64bit/master/Dockerstuff/sakaki-distcc/docker-compose.yml /docker-compose.yml
#######
ADD https://raw.githubusercontent.com/necrose99/gentoo-on-rpi3-64bit/master/Dockerstuff/sakaki-distcc/gentoo.conf /etc/portage/repos.conf/gentoo.conf
ADD https://raw.githubusercontent.com/necrose99/gentoo-on-rpi3-64bit/master/Dockerstuff/sakaki-distcc/make.conf /etc/portage/make.conf
ADD https://raw.githubusercontent.com/necrose99/gentoo-on-rpi3-64bit/master/Dockerstuff/sakaki-distcc/local.use /etc/portage/package.use/local.use
### 
RUN emerge-webrsync
## add binhost/s so this dont take till xmass of 2525 .. 
RUN eselect profile set default/linux/amd64/17.0/developer
############################################################

############################################################
RUN emerge -uDU --keep-going --getbinpkg --binpkg-respect-use=y --autounmask-continue=y --with-bdeps=y sys-devel/gcc-config dev-go/gox sys-devel/binutils-config app-portage/gentoolkit app-portage/eix
RUN emerge -uDU --keep-going --getbinpkg --binpkg-respect-use=y --autounmask-continue=y --with-bdeps=y  app-portage/portage-utils app-portage/genlop

RUN emerge --getbinpkg --binpkg-respect-use=y --autounmask-continue=y --with-bdeps-auto=y  net-dns/avahi  dev-vcs/git app-portage/layman net-libs/libgssglue   net-dns/avahi
RUN USE="crossdev gssapi zeroconf " emerge --getbinpkg --binpkg-respect-use=y --autounmask-continue=y --with-bdeps-auto=y sys-devel/gcc-config  sys-devel/gcc sys-devel/distcc sys-devel/crossdev sys-devel/ct-ng 
#sys-devel/icecream
RUN emerge -uDU --keep-going --getbinpkg --binpkg-respect-use=y --autounmask-continue=y --with-bdeps=y @world
############################################################
 # net-fs/nfs-utils may add nfs to push out pkgs net-fs/samba net-misc/ngrok::SEEDS needs golang  https tunnels for pkgs out... 
# rm -rf /usr/portage/*
RUN crossdev --ov-output /usr/local/portage -S -v -t armv7a-hardfloat-linux-gnueabi
## drop unkown pretty please makes for metadata hell... like on equo or entrpoy pm convert bins... 
RUN crossdev --ov-output /usr/local/portage -S -v -t arm64-linux-gnu  
############################################################
RUN ( \
    echo "#!/bin/sh" && \
    echo "eval \"\`gcc-config -E\`\"" && \
    echo "exec distccd \"\$@\"" \
  ) > /usr/local/sbin/distccd-launcher && \
  chmod +x /usr/local/sbin/distccd-launcher


# Run icecc daemon in verbose mode
# ENTRYPOINT ["iceccd","-v" 0.0.0.0/0::/0]
# If no-args passed, make very verbose
# CMD ["-vv"]

# iceccd port
EXPOSE 10245 8765/TCP 8765/UDP 8766 22 3632 80
ENTRYPOINT ["/entrypiont.sh"]
