FROM gentoo/stage3-amd64 
 
## Icecream its often easier. 
RUN touch /etc/init.d/functions.sh && \
  echo 'PYTHON_TARGETS="${PYTHON_TARGETS} python2_7"' >> /etc/portage/make.conf && \
  echo 'PYTHON_SINGLE_TARGET="python2_7"' >> /etc/portage/make.conf

RUN \
  emerge --sync && \
  emerge gcc  sys-devel/crossdev sys-devel/ct-ng sys-devel/icecream  && \
 # rm -rf /usr/portage/*

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
EXPOSE 10245 8765/TCP 8765/UDP 8766
