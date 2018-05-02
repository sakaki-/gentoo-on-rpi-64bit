#/bin/bash
## https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Set-Up-Your-Gentoo-PC-for-Cross-Compilation-with-crossdev
# and a few mods as crossdev may bork shit drop symlnkys in other repos... 
# @crossdev --clean
 
echo "INIT Arm/Arm64-crossdev targets."
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm:' > /proc/sys/fs/binfmt_misc/register
 
### Initial INIT uncomment this crap.. 
mkdir -pv /usr/local/portage-crossdev/{profiles,metadata}
echo 'crossdev' > /usr/local/portage-crossdev/profiles/repo_name
echo 'masters = gentoo' > /usr/local/portage-crossdev/metadata/layout.conf
chown -R portage:portage /usr/local/portage-crossdev
gentoo_pc ~ # echo 'thin-manifests = true' >> /usr/local/portage-crossdev/metadata/layout.conf
#cat <<EOF >> /usr/local/portage-crossdev/metadata/layout.conf
#[crossdev]
 
#location = /usr/local/portage-crossdev
#priority = 10
#masters = gentoo
#auto-sync = no
#EOF
 
## recoment above Mkdir -eof if you going to re-int repo via crossdev clean/etc ie cronjob. 
#
crossdev -t aarch64-unknown-linux-gnu --stable --init-target -oO /usr/local/portage-crossdev/
crossdev -t armv7a-hardfloat-linux-gnueabi --stable --init-target -oO /usr/local/portage-crossdev/
 
## fire up crossdev
## might have perfecly married both starters.. 
## ****dropping unknown**** from arm64 it fuggles metadata. entropy
crossdev -t aarch64-linux-gnu --stable -oO -oO /usr/local/portage-crossdev/
crossdev -t armv7a-hardfloat-linux-gnueabi --stable -oO /usr/local/portage-crossdev/
 
## boot strap we can more sexy later in porthole and or manual re-emerge's...
## gcc to build sometimes you may need to "Massage" it in porthole anyhow... if it fails add more opts as you go.
crossdev -v -t aarch64-linux-gnu --genv 'USE="cxx multilib fortran -mudflap nls openmp -sanitize  objc objc++ objc-gc graphite pgo vtv cilk go pie"' -oO /usr/local/portage-crossdev/
crossdev -v -t armv7a-hardfloat-linux-gnueabi --genv 'USE="cxx multilib fortran -mudflap nls openmp -sanitize  objc objc++ objc-gc graphite pgo vtv cilk go pie"' -oO /usr/local/portage-crossdev/
