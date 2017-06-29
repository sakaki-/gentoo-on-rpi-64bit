**For Full Documentation SEE**

\@ <https://github.com/sakaki-/gentoo-on-rpi3-64bit>

<https://www.dropbox.com/home/sakaki--gentoo-on-rpi3-64bit/packages-rpi3-arm64>

**\@Necrose99’s mini repo… , if you have dropbox and 16 gigs+ it would be wise
to just take the whole thing**

**WARRRRRRRRRRNINGGGGGG F’ONT USE SYSTEMD or Kill EUDEV , from repo above, less
you get system-D fully integrated , you’ll BIRCK the INIT… and
presto-Reformato….** however this is why i also made a docker , as its like a CHROOT , mount packages volume... give it an IP and ssh...
packages out to host kill docker poof gone , refire docker image wala reset. 

**(I’ll have to Backup, and reload BINS folders etc but no biggy… made a recent
enough backup. )**

**( Get a stage 3 unpack to /test-arm64 , kill its INIT… and build if you want
system-D for latter’s… and or DBUS… can copy packages into from …../packages dir
to ……/\$chroot/usr/portage/packages…**

**Build what you need , and yes do add another clone of SAKAKI to a card , as
System-D and RPI needs a Dev’s touch and not a Engineers meddlesome tinkering…
ATM…**

**Was able to –oneshot –buildpkg only SYSTEMD, with Gentoo stock Kernel… but it
will grow without a chroot. )**

for Docker etc , that might run on a SAKAKI Gentoo PI mini repo Above. (Not the
most efficient means but for now it’s what i have,)

**However if you have a Few RPI's or** [Banana-pi
64](http://www.banana-pi.org/m64.html)**’s**

(they are slightly more powerful \@ 2 gigs of ram etc. but basically PI
compatible. )

<https://resin.io>/ as you can command the images (it just runs Docker.) , With
GitHub pushes. dev-ops is like the new Magic... rocket Sci… in IT... the
Resin.io , you can run the **SAKAKI Docker Image**… and **DistCC on Docker
slaves, or Parallel emerges with cluster software… and send you builder pi/s
commands to emerge goddies..**

And or any cluster software, to spawn emerge..

**https://www.dropbox.com/home/sakaki--gentoo-on-rpi3-64bit?preview=pi-back.sh**

Useful in Dumping The PI; As to make a Docker, I wanted the full FS root in a
tarb-ball snapshot.

*(‘Tis slow as Death, so I’d Cron-task it to run overnight)*

[https://www.dropbox.com/s/nebngz1mybua2mt/sakaki--gentoo-rpi3-ARM64bit.tar.gz?dl=0](https://www.dropbox.com/s/nebngz1mybua2mt/sakaki--gentoo-rpi3-ARM64bit.tar.gz?dl=0%20)
**8 gigs includes a few more packages..** Docker ETC on it , extra
[Sabayon](sabayon.org)-ic EQUO Entropy , Molecule , Entropy Server , and other
goodies inside. golang etc.

**many “\@ Gun point Emerges.” Cd /usr/portage/???/packagename/ebuild-name… and
or key wording hacks.**

**As a real nicety if I can get a bootable ISO or grub to actually work ….; Much
like DEBIAN Arm64 ISO.**

<http://softiron.com/products/overdrive-3000/technical-specifications/>

**However I’m Dry on Funds but soon…. (Nothing like a big family weding 1500
miles… and a few mo. Of notice… to put you in the red… and “R.N” / COTTONY**
*in-laws pawing for \$\$ either***.)**

**8 x 64-bit ARM Cortex A57 Cores, up to 128 GIGS of Ram I think. CPU are nearly
Identical but for more cores. If you take the I-5 VS I-7 X64 Intel slant they
are kissing cousins… so Many of SAKAKI’s Packages should have the Added bonus of
running just fine. On the 3000 or 1000 dev-box.**

