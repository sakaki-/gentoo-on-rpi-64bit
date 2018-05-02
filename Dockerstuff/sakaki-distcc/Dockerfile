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
## Bootstrap langs... #######################
RUN mkdir -p /var/lib/layman/ && mkdir -p /usr/portage/packages && touch /var/lib/layman/make.conf
## make an emmpty stub file grrr..  layman is not yet installed. tempoarally quiets make.conf fail... in portage
## however soon as layman is installed works.. 
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/dev-lang/python-2.7.14-r1.tbz2 /usr/portage/packages/dev-lang/
#python
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/dev-lang/go-1.10.1.tbz2 /usr/portage/packages/dev-lang/
# go
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/dev-lang/rust-1.25.0.tbz2 /usr/portage/packages/dev-lang/
# rust
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/dev-lang/perl-5.24.3-r1.tbz2 /usr/portage/packages/dev-lang/
## perl
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/dev-lang/tcl-8.6.6.tbz2 /usr/portage/packages/dev-lang/
## tcl
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/dev-lang/tk-8.6.6.tbz2 /usr/portage/packages/dev-lang/
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/dev-lang/python-3.5.5.tbz2 /usr/portage/packages/dev-lang/
## tk

#################### dev-vcs ##################
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/dev-vcs/git-2.16.1.tbz2 /usr/portage/packages/dev-vcs/
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/dev-vcs/bzr-2.7.0.tbz2 /usr/portage/packages/dev-vcs/
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/dev-vcs/cvs-1.12.12-r12.tbz2 /usr/portage/packages/dev-vcs/
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/dev-vcs/mercurial-4.5.2.tbz2 /usr/portage/packages/dev-vcs/
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/dev-vcs/subversion-1.9.7-r1.tbz2 /usr/portage/packages/dev-vcs/
######
################ /sys-devel ##########
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/sys-devel/gcc-config-1.8-r1.tbz2 /usr/portage/packages/sys-devel/
# ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/sys-devel/gcc-7.3.0-r1.tbz2 /usr/portage/packages/sys-devel/
#too big or leaves layer. 
ADD http://mirror.switch.ch/ftp/mirror/pentoo/Packages/amd64-default/sys-devel/crossdev-20171230.tbz2 /usr/portage/packages/sys-devel/
ADD http://mirror.switch.ch/ftp/mirror/pentoo/Packages/amd64-default/sys-devel/gdb-7.12.1.tbz2  /usr/portage/packages/sys-devel/
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/sys-devel/binutils-config-5-r4.tbz2 /usr/portage/packages/sys-devel/
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/sys-devel/binutils-2.30-r2.tbz2 /usr/portage/packages/sys-devel/
## /sys-libs
## dev-db/sqlite /usr/portage/packages/dev-db
ADD http://mirror.switch.ch/ftp/mirror/pentoo/Packages/amd64-default/dev-db/sqlite-3.23.1.tbz2 /usr/portage/packages/dev-db/

### DNS 
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/net-dns/avahi-0.7-r1.tbz2 /usr/portage/packages/net-dns/
#net-libs /usr/portage/packages/net-libs/ net-libs/libgssglue

############## portage 
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/app-portage/eix-0.32.9.tbz2  /usr/portage/packages/app-portage/
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/app-portage/genlop-0.30.9-r1.tbz2  /usr/portage/packages/app-portage/
ADD http://mirror.switch.ch/ftp/mirror/pentoo/Packages/amd64-default/app-portage/smart-live-rebuild-1.3.5.tbz2 /usr/portage/packages/app-portage/
ADD http://mirror.switch.ch/ftp/mirror/pentoo/Packages/amd64-default/app-portage/layman-2.4.2-r1.tbz2 /usr/portage/packages/app-portage/
ADD http://mirror.switch.ch/ftp/mirror/pentoo/Packages/amd64-default/app-portage/eix-0.32.9.tbz2 /usr/portage/packages/app-portage/
ADD http://mirror.math.princeton.edu/pub/redcorelinux/packages/app-portage/gentoolkit-0.4.0.tbz2 /usr/portage/packages/app-portage/


## 

RUN emerge-webrsync
## add binhost/s so this dont take till xmass of 2525 .. 
RUN eselect profile set default/linux/amd64/17.0/developer
############################################################
RUN cd /usr/portage/packages/dev-lang/ && emerge --nodeps tk-8.6.6.tbz2   tcl-8.6.6.tbz2   perl-5.24.3-r1.tbz2  python*.tbz2
RUN cd /usr/portage/packages/dev-db/ && emerge --nodeps sqlite-3.23.1.tbz2
RUN  USE="tcl" emerge -v sys-libs/db
RUN emerge -uDngU --keep-going --getbinpkg --newuse --binpkg-respect-use=y --autounmask-continue=y --with-bdeps=y @system
############################################################
RUN emerge --nodeps /usr/portage/packages/dev-vcs/git-2.16.1.tbz2 && emerge --nodeps /usr/portage/packages/dev-vcs/subversion-1.9.7-r1.tbz2
RUN emerge  --nodeps  /usr/portage/packages/dev-lang/go-1.10.1.tbz2 && emerge --nodeps usr/portage/packages/dev-lang/rust-1.25.0.tbz2
RUN emerge --nodeps /usr/portage/packages/app-portage/eix-0.32.9.tbz2  && emerge --nodeps /usr/portage/packages/app-portage/gentoolkit-0.4.0.tbz2
RUN emerge --nodeps /usr/portage/packages/app-portage/smart-live-rebuild-1.3.5.tbz2 && emerge --nodeps /usr/portage/packages/app-portage/layman-2.4.2-r1.tbz2
RUN emerge --nodeps /usr/portage/packages/sys-devel/gcc-config-1.8-r1.tbz2 

RUN cd /usr/portage/packages/sys-devel/ && wget http://mirror.math.princeton.edu/pub/redcorelinux/packages/sys-devel/gcc-7.3.0-r1.tbz2 && emerge --nodeps gcc-7.3.0-r1.tbz2
RUN cd /usr/portage/packages/sys-devel/ && wget http://mirror.switch.ch/ftp/mirror/pentoo/Packages/amd64-default/sys-devel/crossdev-20171230.tbz2 && emerge --nodeps crossdev-20171230.tbz2
RUN emerge --nodeps /usr/portage/packages/sys-devel/binutils-config-5-r4.tbz2  && emerge --nodeps /usr/portage/packages/sys-devel/binutils-2.30-r2.tbz2
RUN emerge dev-go/gox
RUN emerge -uDngU --keep-going --getbinpkg --newuse --binpkg-respect-use=y --autounmask-continue=y --with-bdeps=y @world
############################################################
 # net-fs/nfs-utils may add nfs to push out pkgs net-fs/samba net-misc/ngrok::SEEDS needs golang  https tunnels for pkgs out... 
# rm -rf /usr/portage/*

### init crossdev kits 
ADD https://raw.githubusercontent.com/necrose99/gentoo-on-rpi3-64bit/master/Dockerstuff/sakaki-distcc/init-crossdev-arm.sh /
RUN /init-crossdev-arm.sh
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
