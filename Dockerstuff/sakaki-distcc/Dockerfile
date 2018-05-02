FROM gentoo/stage3-amd64 
 
## Icecream its often easier.  howver for now not that many to build on. 
## USE Zeroconf to make it stupidly EASY... 
RUN touch /etc/init.d/functions.sh && \
  echo 'PYTHON_TARGETS="${PYTHON_TARGETS} python2_7"' >> /etc/portage/make.conf && \
  echo 'PYTHON_SINGLE_TARGET="python2_7"' >> /etc/portage/make.conf
ADD https://raw.githubusercontent.com/necrose99/gentoo-on-rpi3-64bit/master/Dockerstuff/sakaki-distcc/entrypoint.sh /entrypoint.sh
ADD https://raw.githubusercontent.com/necrose99/gentoo-on-rpi3-64bit/master/Dockerstuff/sakaki-distcc/docker-compose.yml /docker-compose.yml
RUN emerge--webrsync
RUN USE="crossdev gssapi zeroconf " emerge sys-devel/gcc-config net-libs/libgssglue  sys-apps/dbus sys-devel/gcc sys-devel/distcc sys-devel/crossdev sys-devel/ct-ng sys-devel/icecream  net-dns/avahi  dev-vcs/git app-portage/layman
 
 # net-fs/nfs-utils may add nfs to push out pkgs net-fs/samba net-misc/ngrok::SEEDS needs golang  https tunnels for pkgs out... 
# rm -rf /usr/portage/*
RUN crossdev --ov-output /usr/local/portage -S -v -t armv7a-hardfloat-linux-gnueabi
RUN crossdev --ov-output /usr/local/portage -S -v -t arm64-linux-gnu  
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
