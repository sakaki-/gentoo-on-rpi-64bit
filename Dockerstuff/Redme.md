[![Docker Repository on Quay](https://quay.io/repository/necrose99/gentoo-on-rpi3-64bit/status "Docker Repository on Quay")](https://quay.io/repository/necrose99/gentoo-on-rpi3-64bit)
https://quay.io/repository/necrose99/gentoo-on-rpi3-64bit

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
2 gigs+ (might have to format usb to swap....\@ 16ish gigs)
https://quay.io/repository/necrose99/gentoo-on-rpi3-64bit

https://hub.docker.com/r/necrose99/gentoo-on-rpi3-64bit/builds/

next rub is the gentoo emulation. however the docker container builds just toook
a crap ton of time to upload a FS dump to dropbox and yank into quay.io.

https://hub.docker.com/r/necrose99/gentoo-on-rpi3-64bit/builds/

\@ <https://github.com/sakaki-/gentoo-on-rpi3-64bit>

<https://www.dropbox.com/home/sakaki--gentoo-on-rpi3-64bit/packages-rpi3-arm64>

**\@Necrose99’s mini repo… , if you have dropbox and 16 gigs+ it would be wise
to just take the whole thing**
[packages](https://www.dropbox.com/home/sakaki--gentoo-on-rpi3-64bit?preview=Packages.txt)
note may change over time as I upload more or get a WEB Mirror .org to do
propper mirroring.

**WARRRRRRRRRRNINGGGGGG F’ONT USE SYSTEMD or Kill EUDEV , from repo above, less
you get system-D fully integrated , you’ll BIRCK the INIT… and
presto-Reformato…. (I’ll have to Backup, and reload BINS folders etc but no
biggy… made a recent enough backup. )**

| however this is why i also made a docker , as its like a CHROOT , mount packages volume... give it an IP and ssh...                                                                                                                                                       |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| packages out to host kill docker poof gone , refire docker image wala reset. if you poor gasoline onto the image and burn , quit tada ITS back... if you got good builds , no problemo its back to pristine after reset.                                                  |
| DOCKER is Ephemeral so read up on **VOL VOLUME** tage and or exposing a dir via nfs or sshfs to push/pull packages.                                                                                                                                                       |
| though it will cache to disk it will rest , like a RAM drive , so for making a prisitne chroot build enviorment, DEVS love and swear by it. if you have an APT,,, , and dont have room for shiny servers QUAY.io and letting it cloud build is handy... and a good buddy. |

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
commands to emerge goddies.. And or any cluster software, to spawn emerge..**

###### **Note I'm A Docker Enthusiast with some Experience but not as much as I really need.**

\`\`\`From USERNAME/conatiner name" can use the SAKAKI RPI 3 tarball dump to
create a container. FROM SCRATCH or use the template for thyn own.

ADD mystuff.tgz /scripts

RUN ./scripts/myscripts

**\#\#HOWEVER**

| Inline-style: 
![borgcube](https://vignette3.wikia.nocookie.net/scifi/images/7/76/Borg_cube.jpg/revision/latest?cb=20130523191156)                                                                                                     |
|----------------------------------------------------------------------------------------------------------------------------------------------|
| **RESISTANCE IS FUTILE ASSILIATE the CONTAINER,**  via FROM *and fork IT. Into you own,* ADD stuff , RUN –privileged / RUN stuff, IE Emerge… |

Or abuse the templates… provided…
---------------------------------

**You can FROM Orignial image, add to it , fork add, new image add more, etc..**

| Inline-style: [./media/image2.vs](./media/image2.vs)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Kinda like a wedding Cake or Rushian Dolls**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| Inline-style: [./media/image3.jpg](./media/image3.jpg) you can have Docker do lots of work as you minion.. for CI or not wanting to take you main box down… If a chroot fails its isolated from your box, Docker will just re-spawn… However if the chroot was so bad a fail , it could crash your server , corrupt you real Gentoo box .. and worse , UNLIKELY but possible.. , Docker *is like a surge protector* for really unstable packages… if they fail bad, the container will die , and reload… , next re-do your test case… For Security testing, I’m looking to milk it as a security Engineer to test, test, & test… for all the vulns… however I need more training with Docker etc.. |

step 1, now fork , now do step 2.. etc.. if someone makes a ..
/Docker/stuff/QEMU-builder

FROM necrose99/gentoo-on-rpi3-64bit ,

\*\*\* ...remind me to Amazon YOU Good Sir/M'amm a flipping case of BEER...

\*\*\* as gentoo-arm64 has been powning me for more than a year .. time
permitting , to fiddle with over a few hours to fix here or ther

. you can get proot static and UMEQ https://github.com/mickael-guene/umeq to
fire in a local chroot. but not in docker...

https://github.com/multiarch/qemu-user-static (uberfat binaries?) also on the
please if this works.... as is thier Busybox.. if i need native shell to fire
emu & bash ie /bb/bb-sh run-emu-start-arm64-bash.sh , Gentoo is troublesome with
the arm64 emu...

**--------------**

**https://github.com/larsks/undocker**

**\@Mulder** of **\@Sabayon** /bow.... (*we're not worthy....)* use docker to
build Sabayon Linux

RPI3 32 bit images Via QEMU and docker. also Sabayon uses (*if memory serves me
correct..).* undocker to pull yank spank into ISO's <https://github.com/sabayon>
some mayhap better examples , than m'yn own. so drop by and learn away..

**mine are of the noobish quick and dirty**.. Examples in this read.me... (*some
Pseudocode…*)

| **FROM DEBIAN-ARM64**                                                        |
|------------------------------------------------------------------------------|
| **\#(has working QEMU) \#\# NEED TO GET reg-emu running, and not have too.** |
| **ADD saki….tar-balll /rpi64-builder….**                                     |
| **ADD chroot-me.sh**                                                         |
| **VOL /packages**                                                            |
| **\#\# add a lazy package dir or expose via SSHFS see docker doc’s… etc…**   |
| **RUN mount –sbind … /packages /rpi64-builder/usr/portage/packages**         |
| **ADD build-lots.sh**                                                        |
| **RUN build-lots.sh.. \# emerge lots of stuff....**                          |

`‘’’temerimanal or Quay.io , dockerhub : **\@\@\@ eix-sync…..**’’’`

<https://www.dropbox.com/home/sakaki--gentoo-on-rpi3-64bit?preview=pi-back.sh>
**needs a touch of work…Useful in Dumping The PI; As to make a Docker, I wanted
the full FS root in a tarb-ball snapshot.**

*(‘Tis slow as Death, so I’d Cron-task it to run overnight few hours)*

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


