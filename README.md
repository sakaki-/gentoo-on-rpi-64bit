# gentoo-on-rpi3-64bit
Bootable 64-bit Gentoo image for the Rasperry Pi 3, with Linux 4.10.0, OpenRC, Xfce4, VC4

## Description

<img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi3/Raspberry_Pi_3_B.jpg" alt="Raspberry Pi 3 B" width="250px" align="right"/>
This project is a bootable, microSD card **64-bit Gentoo image for the [Raspberry Pi 3 model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)** single board computer (SBC).

The image's userland contains a complete (OpenRC-based) Gentoo system (including a full Portage tree) - so you can run `emerge` operations immediately - and has been pre-populated with a reasonable package set (Xfce v4.12, Firefox v50.1.0, Claws Mail v3.14.1, VLC v2.2.4, AibWord v3.0.2 etc.) so that you can get productive *without* having to compile anything first (unless you wish to do so, of course ^-^).

The kernel and userland are both 64-bit (`arm64`/`aarch64`), and support for the Pi's [VC4](https://wiki.gentoo.org/wiki/Raspberry_Pi_VC4) GPU has been included (using [`vc4-fkms-v3d`](https://www.raspberrypi.org/forums/viewtopic.php?f=29&t=159853) / Mesa), so rendering performance is reasonable (e.g., `glxgears` between 400 and 1000fps, depending on load; real-time video playback). The Pi's onboard Ethernet, WiFi and Bluetooth adaptors are supported. Sound works too, both via HDMI (given an appropriate display), and the onboard headphone jack.

Here's a screenshot:

<img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi3/demo-screenshot-small.jpg" alt="gentoo-on-rpi3-64bit in use (screenshot)" width="960px"/>

> Note, the kernel config used was derived simply by running `make bcmrpi3_defconfig` on the `rpi-4.10.y` branch of the Raspberry Pi [kernel tree](https://github.com/raspberrypi/linux); but, for reference, may be viewed [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/configs/bcmrpi3_defconfig).

The image may be downloaded from the link below (or via `wget`, per the instructions which follow).

Variant | Version | Image | Digital Signature
:--- | ---: | ---: | ---:
Raspberry Pi 3 Model B 64-bit | v1.0.0 | [genpi64.img.xz](https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.0.0/genpi64.img.xz) | [genpi64.img.xz.asc](https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.0.0/genpi64.img.xz.asc)

Please read the instructions below before proceeding. Also please note that all images are provided 'as is' and without warranty. You should also be comfortable with the (at the moment, unavoidable) non-free licenses required by the firmware and boot software supplied on the image before proceeding: these may be reviewed [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/tree/master/licenses).

> It is sensible to install Gentoo to a **separate** microSD card from that used by your default Raspbian system; that way, when you are finished using Gentoo, you can simply power off, swap back to your old card, reboot, and your original system will be just as it was.

> Please also note that support for `arm64` is still in its [early stages](https://wiki.gentoo.org/wiki/Raspberry_Pi) with Gentoo, so it is quite possible that you may encounter strange bugs etc. when running a 64-bit image such as this one. A lot of packages have been `* ~*` keyworded to get the system provided here to build... but hey, if you like Gentoo, little things like that aren't likely to put you off ^-^

## Prerequisites

To try this out, you will need:
* A [microSD](https://en.wikipedia.org/wiki/Secure_Digital) card of _at least_ 8GB capacity (the image is 675MiB compressed, 7.31GiB == 7.85GB uncompressed, so should fit on any card marked as >= 8GB). If you intend to build large packages (or kernels) on your RPi3, a card of >=16GB is _strongly_ recommended (the root partition will [automatically be expanded](#morespace) to fill the available space on your microSD card, on first boot). Depending on the slots available on your PC, you may also need an adaptor to allow the microSD card to be plugged in (to write the image to it initially).
   > I have found most SanDisk cards work fine; if you are having trouble, a good sanity check is to try writing the [standard Raspbian 32-bit image](https://www.raspberrypi.org/downloads/raspbian/) to your card, to verify that your Pi3 will boot with it, before proceeding.
  
* A Raspberry Pi 3 Model B (obviously!). (The image is also usable for RPi3 boards in chassis such as the [Pi-Top](https://www.pi-top.com/product/pi-top), but you'll need to source additional components in such a case for battery control etc., see e.g. [here](https://github.com/rricharz/pi-top-install).)
For simplicity, I am going to assume that you will be logging into the image (at least initally) via an (HDMI) screen and (USB) keyboard connected directly to your Pi, rather than e.g. via `ssh` (although, for completeness, it *is* possible to `ssh` in via the Ethernet interface (which has a DHCP client running), if you can determine the allocated IP address, for example from your router).

* A PC to decompress the image and write it to the microSD card. This is most easily done on a Linux machine of some sort, but tools are also available for Windows (see [here](http://tukaani.org/xz/) and [here](http://sourceforge.net/projects/win32diskimager/), for example). In the instructions below I'm going to assume you're using Linux.
   > It is possible to use your Raspberry Pi for this task, if you have an external card reader attached, or if you have your root on e.g. USB (and take care to unmount your existing /boot directory before removing the original microSD card), or are booted directly from USB. Most users will find it simplest to write the image on a PC, however.

## Downloading and Writing the Image

On your Linux box, issue:
```console
# wget -c https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.0.0/genpi64.img.xz
# wget -c https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.0.0/genpi64.img.xz.asc
```
to fetch the compressed disk image file (~675MiB) and its signature.

Next, if you like, verify the image using gpg (this step is optional):
```console
# gpg --keyserver pool.sks-keyservers.net --recv-key DDE76CEA
# gpg --verify genpi64.img.xz.asc genpi64.img.xz
```

Assuming that reports 'Good signature', you can proceed. (Warnings that the key is "not certified with a trusted signature" are normal and [may be ignored](http://security.stackexchange.com/questions/6841/ways-to-sign-gpg-public-key-so-it-is-trusted).)

Next, insert (into your Linux box) the microSD card on which you want to install the image, and determine its device path (this will be something like `/dev/sdb`, `/dev/sdc` etc. (if you have a [USB microSD card reader](http://linux-sunxi.org/Bootable_SD_card#Introduction)), or perhaps something like `/dev/mmcblk0` (if you have e.g. a PCI-based reader); in any case, the actual path will depend on your system - you can use the `lsblk` tool to help you). Unmount any existing partitions of the card that may have automounted (using `umount`). Then issue:

> **Warning** - this will *destroy* all existing data on the target drive, so please double-check that you have the path correct! As mentioned, it is wise to use a spare microSD card as your target, keeping your existing Raspbian microSD card in a safe place; that way, you can easily reboot back into your existing Raspbian system, simply by swapping back to your old card.

```console
# xzcat genpi64.img.xz > /dev/sdX && sync
```

Substitute the actual microSD card device path, for example `/dev/sdc`, for `/dev/sdX` in the above command. Make sure to reference the device, **not** a partition within it (so e.g., `/dev/sdc` and not `/dev/sdc1`; `/dev/sdd` and not `/dev/sdd1` etc.)
> If, on your system, the microSD card showed up with a path of form `/dev/mmcblk0` instead, then use this as the target, in place of `/dev/sdX`. For this naming format, the trailing digit *is* part of the drive name (partitions are labelled as e.g. `/dev/mmcblk0p1`, `/dev/mmcblk0p2` etc.). So, for example, you might need to use `xzcat genpi64.img.xz > /dev/mmcblk0 && sync`.

The above `xzcat` to the microSD card will take some time, due to the decompression (it takes between 5 and 15 minutes on my machine, depending on the microSD card used). It should exit cleanly when done - if you get a message saying 'No space left on device', then your card is too small for the image, and you should try again with a larger capacity one.
> <a name="morespace"></a>Note that on first boot, the image will _automatically_ attempt to resize its root partition (which, in this image, includes `/home`) to fill all remaining free space on the microSD card, by running [this script](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/autoexpand_root_partition.start) (located at `/etc/local.d/autoexpand_root_partition.start`); if you _do not_ want this to happen (for example, because you wish to add extra partitions to the microSD card later yourself), then simply delete the (empty) sentinel file `autoexpand_root_partition` from the `/boot` (i.e., first) microSD card partition, before proceeding.

> Please note that if you _do_ choose to delete the `autoexpand_root_partition` sentinel file, once booted you will need to (textually) login as root and issue `rc-update add xdm default; service xdm start` to start the `demouser` account graphical login process - it will not start up automatically for you, as it will for users following the default flow.

## <a name="booting"></a>Booting!

Begin with your RPi3 powered off. Remove the current (Raspbian or other) microSD card from the board (if fitted), and store it somewhere safe.

Next, insert the (Gentoo) microSD card you just wrote the image to into the Pi. Apply power.

You should get the RPi3's standard 'rainbow square' on-screen for about 10 seconds, and then see a text console appear (once the graphics driver has loaded), showing OpenRC starting up. On this first boot (unless you have deleted the sentinel file `autoexpand_root_partition` in the microSD card's first partition), the system will, after 20 seconds or so, _automatically resize_ the root partition to fill all remaining free space on the drive, and, having done this, reboot (to [allow the kernel to see](http://unix.stackexchange.com/questions/196435/is-it-possible-to-enlarge-the-partition-without-rebooting) the new partition table). You should then see the 'rainbow square' once more, then about 20 seconds of OpenRC startup messages, and then the system will resize its root filesystem. Once this is done, it will automatically proceed to start a standard Xfce desktop (logged in automatically to the pre-created `demouser` account):

<img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi3/xfce-desktop-small.png" alt="Baseline Xfce desktop" width="960px"/>

The whole process (from first power on to graphical desktop) should take less than two minutes or so (on subsequent reboots, the resizing process will not run, so it will be faster).

> The initial **root** password on the image is **raspberrypi64**. The password for **demouser** is also **raspberrypi64** (you may need this if e.g. the screen lock comes on). The screensaver for `demouser` has been disabled by default on the image.

## Using Gentoo

The supplied image contains a fully-configured `~arm64` Gentoo system (*not* simply a [minimal install](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Media#Minimal_installation_CD) or [stage 3](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Media#What_are_stages_then.3F)), with a complete Portage tree already downloaded, so you can immediately perform `emerge` operations etc. Be aware that, as shipped, it uses **UK locale settings, keyboard mapping and timezone**; however, these are easily changed if desired. See the Gentoo Handbook ([here](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Base#Timezone) and [here](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/System#Init_and_boot_configuration)) for details.

The full set of packages (from `/var/lib/portage/world`) in the image may be viewed [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/world-packages) (note that the version numbers shown in this list are Gentoo ebuilds, but they generally map 1-to-1 onto upstream package versions).
> The *full* package lists for the image (including @system and dependencies) may also be viewed, [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/world-all-packages).

The system on the image has been built via a minimal install system and stage 3 from Gentoo (`arm64`, available [here](http://distfiles.gentoo.org/releases/arm/autobuilds/current-stage3-arm64/)), but _all_ binaries (libraries and executables) have been rebuilt to target the Raspberry Pi 3 B's BCM2837 SoC specifically (the `/etc/portage/make.conf` file used on the image may be viewed [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/make.conf)). The CHOST on the image is `aarch64-unknown-linux-gnu` (per [these notes](https://wiki.gentoo.org/wiki/User:NeddySeagoon/Pi3#Getting_Started)). All packages have been brought up to date against the Gentoo tree as of 28 January 2017.

> Note: the CFLAGS used for the image build is `-march=armv8-a+crc -mtune=cortex-a53 -O2 -pipe`. You can of course re-build selective components with more aggressive flags yourself, should you choose. As the SIMD FPU features are standard in ARMv8, there is no need for `-mfpu=neon mfloat-abi=hard` etc., as you would have had on e.g. the 32-bit ARMv7a architecture. Note that AArch64 NEON also has a full IEEE 754-compliant mode (including handling denormalized numbers etc.), there is also need for `-ffastmath` flag to fully exploit the FPU either (again, unlike earlier ARM systems). Please refer to the official [Programmer’s Guide for ARMv8-A](http://infocenter.arm.com/help/topic/com.arm.doc.den0024a/DEN0024A_v8_architecture_PG.pdf) for more details.

When logged in as `demouser`, it is sensible to change the password (from `raspberrypi64`) and `root`'s password (also from `raspberrypi64`). Open a terminal window and do this now:
```console
demouser@pi64 ~ $ passwd
Changing password for demouser.
(current) UNIX password: <type raspberrypi64 and press Enter>
New password: <type your desired password, and press Enter>
Retype new password: <type the desired password again, and press Enter>
passwd: password updated successfully
demouser@pi64 ~ $ su -
Password: <type raspberrypi64 and press Enter, to become root>
pi64 ~ # passwd
New password: <type your desired password for root, and press Enter>
Retype new password: <type the desired root password again, and press Enter>
passwd: password updated successfully
pi64 ~ # exit
logout
demouser@pi64 ~ $
```

If you want to create your own account, you can do so easily. Open a terminal, su to root, then issue (adapting with your own details, obviously!):
```console
pi64 ~ # useradd --create-home --groups "adm,disk,lp,wheel,audio,video,cdrom,usb,users,plugdev,portage" --shell /bin/bash --comment "Sakaki" sakaki
pi64 ~ # passwd sakaki
New password: <type your desired password for the new user, and press Enter>
Retype new password: <type the desired password again, and press Enter>
pi64: password updated successfully
```

You can then log out of `demouser`, and log into your new account, using the username and password just set up. Once logged in, you can delete the `demouser` account if you like. Open a terminal, `su` to root, then:
```console
pi64 ~ # userdel --remove demouser
userdel: demouser mail spool (/var/spool/mail/demouser) not found
```
> The mail spool warning may safely be ignored. Also, if you want your new user to be automatically logged in on boot (as `demouser` was), sustitute your new username for `demouser` in the file `/etc/lightdm/lightdm.conf.d/50-autologin-demouser.conf` (and if you do _not_ want autologin, this file may safely be deleted).

Have fun! ^-^

## Miscellaneous Points

* For simplicity, the image uses a single `ext4` root partition (includes `/home`), which [by default](#morespace) will be auto-resized to fill all remaining free space on the microSD card on first boot. Also, to allow large packages (such as `gcc`) to be built without running out of memory, a 2 GiB swapfile has been set up at `/var/cache/swap/swap1`. Feel free to modify this configuration as desired (be sure to change `/etc/fstab` if you do).
   > Incidentally, it *is* possible to get the Pi 3 to boot from a USB drive (no microSD card required); see for example [these instructions](http://www.makeuseof.com/tag/make-raspberry-pi-3-boot-usb/). However, try this at your own risk! Alternatively, you can retain `/boot` on the microSD card, but use a USB drive for the system root (remember to modify `/boot/cmdline.txt` and `/etc/fstab` accordingly, if you choose to go this route).

* The image is subscribed to the following overlays:
  * [sakaki-tools](https://github.com/sakaki-/sakaki-tools): this provides the convenience scripts `showem` ([source](https://github.com/sakaki-/showem), [manpage](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/showem.pdf)), and `genup` ([source](https://github.com/sakaki-/genup), [manpage](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/genup.pdf)).
  * [rpi3](https://github.com/sakaki-/rpi3-overlay): this provides ebuilds specific to the Raspberry Pi 3, or builds that have fallen off the main Gentoo tree but which are the last known reliable variants for `arm64`.
* Because the Pi has no battery-backed real time clock (RTC), I have used the `swclock` (rather than the more usual `hwclock`) OpenRC boot service on the image - this simply sets the clock on boot to the recorded last shutdown time. An NTP client, `chronyd`, is also configured, and this will set the correct time as soon as a valid network connection is established.
   > Note that this may cause a large jump in the time when it syncs, which in turn will make the screensaver lock come on. Not a major problem, but something to be aware of, as it can be quite odd to boot up, log in, and have your screen almost immediately lock! For this reason, the `demouser` account on the image has the screensaver disabled by default.

* The image is configured with `NetworkManager`, so achieving network connectivity should be straightforward. The Ethernet interface is initially configured as a DHCP client, but obviously you can modify this as needed. Use the NetworkManager applet (top right of your screen) to do this; you can also use this tool to connect to a WiFi network.
   > Note that getting WiFi to work on the RPi3 requires up-to-date firmware (installed in `/lib/firmware/brcm`): the appropriate files have been pre-installed on the image, and may also be downloaded directly [here](https://github.com/RPi-Distro/firmware-nonfree). In particular, `/lib/firmware/brcm/brcmfmac43430-sdio.bin` and `/lib/firmware/brcm/brcmfmac43430-sdio.txt` are required.

* Bluetooth *is* operational on this image, but since, by default, the Raspberry Pi 3 [uses the hardware UART](http://www.briandorey.com/post/Raspberry-Pi-3-UART-Overlay-Workaround) / `ttyAMA0` to communicate with the Bluetooth adaptor, the standard serial console does not work and has been disabled on this image (see `/etc/inittab` and `/boot/cmdline.txt`). You can of course [change this behaviour](https://www.raspberrypi.org/forums/viewtopic.php?t=138120) if access to the hardware serial port is important to you.
   > Bluetooth on the RPi3 also requires a custom firmware upload. This is carried out by a boot-time script (in `/etc/local.d/bluetooth.start`), which uses the `hciattach` utility to upload a firmware blob from `/etc/firmware/BCM43430A1.hcd` (sic). The firmware is pre-installed on the image, and may also be downloaded directly [here](https://aur.archlinux.org/pi-bluetooth.git).

* The Pi3 uses the first (`vfat`) partition of the microSD card (`/dev/mmcblk0p1`) for booting. The various (closed-source) firmware files pre-installed there may be separately downloaded [here](https://github.com/raspberrypi/firmware.git). Once booted, this first partition will be mounted at `/boot`, and you may wish to check or modify the contents of the files `/boot/cmdline.txt` and `/boot/config.txt`.

* Because of licensing issues (specifically, [`bindist`](https://packages.gentoo.org/useflags/bindist) compliance), Mozilla Firefox has been distributed in its 'developer' edition - named 'Aurora'. Bear in mind that this app will take quite a long time (20 to 30 seconds) to start on first use, as it sets up its local storage in `~/.mozilla/<...>`.
   > Firefox works, but can feel a rather sluggish at times on the Pi. To improve it, turn on fetch pipelining and the improved back-end cache via about:config; see [these instructions](https://www.maketecheasier.com/speed-up-firefox-http-pipelining/) for example, and also [here](https://gist.github.com/amorgner/6746802).

* I have also pre-installed the lighter-weight Links browser on the image, in case you would like to use this in preference to Firefox. Claws Mail has been pre-installed to provide a fully-featured mail client.
   > At the time of writing, I have not been able to build an `arm64` version of Thunderbird that works reliably on the RPi3.

* By default, the image uses the Pi's [VC4 GPU](https://wiki.gentoo.org/wiki/Raspberry_Pi_VC4) acceleration in X, which has reasonable support in the 4.10.y kernel and the supplied userspace (via `media-libs/mesa` etc.) Note however that this is still work in progress, so you may experience issues with certain applications. The image uses the mixed-mode [`vc4-fkms-v3d`](https://www.raspberrypi.org/forums/viewtopic.php?f=29&t=159853) overlay / driver (see `/boot/config.txt`). On my RPi3 at least, a `glxgears` score of ~750fps can be obtained on an unloaded system (~400fps on a loaded desktop) - in the same ballbark as the non-free Raspbian driver. YMMV - if you experience problems with this setup (or find that e.g. your system is stuck on the 'rainbow square' at boot time after a kernel update), you can fall-back to the standard framebuffer mode by commenting out the `dtoverlay=vc4-fkms-v3d` line in `/boot/config.txt` (i.e., the file `config.txt` located in the microSD card's first partition).
   > Both VLC and SMPlayer have been pre-installed on the image, and they will both make use of accelerated (Mesa/gl) playback. Because of incompatibilities and periodic crashes when using it, XVideo (xv) mode has been disabled in the X server (`/etc/X11/xorg.conf.d/50-disable-Xv.conf`); this doesn't really impinge on usability.

* ALSA sound on the system is operative and routed by default through the headphone jack on the Pi. If you connect a sound-capable HDMI monitor (or television) sound should automatically also play through that device (in parallel) - at the moment there is only one 'master' volume control available.
   > If you are connecting to a computer monitor _without_ sound support, you can safely comment out the `hdmi_drive=2` entry in `/boot/config.txt`, or even set `hdmi_drive=1`; doing so may give you [better display quality](https://github.com/NicoHood/NicoHood.github.io/wiki/Fix-blurry-HDMI-output-with-DVI-mode#user-content-raspberry-pi-fix).

* I haven't properly tested suspend to RAM or suspend to swap functionality yet.
* As mentioned [above](#morespace), by default on first boot the image will attempt to automatically expand the root (second) partition to fill all remaining free space on the microSD card. If, for some reason, you elected _not_ to do this (and so deleted the sentinel file `autoexpand_root_partition`), you can easily expand the size of the second (root) partition manually, so that you have more free space to work in, using the tools (`fdisk` and `resize2fs`). See [these instructions](http://geekpeek.net/resize-filesystem-fdisk-resize2fs/), for example. I **strongly** recommend you do expand the root partition (whether using the default, first-boot mechanism or manually) if you are intending to perform large package (or kernel) builds on your Pi (it isn't necessary just to play around with the image of course).

### <a name="kernelbuild"></a>Recompiling the Kernel (Optional)

If you'd like to compile a kernel on your new system, you can do so easily.

Because (at the time of writing) 64-bit support for the RPi3 is fairly 'cutting edge', you'll need to download the source tree directly, rather than using `sys-kernel/raspberrypi-sources`. I recommend using at least version 4.9.y.

The tree you need is maintained [here](https://github.com/raspberrypi/linux).

> **NB:** if you are running Gentoo on a microSD card, please be sure that you have an expanded root partition (as described [above](#morespace)) on a >=16GB card, before attempting to build a kernel: this process requires more free space than is present on an 8GB card.

Suppose you wish to build the most modern version of the 4.10.y kernel (same major/minor version as on the image). Then, begin by pulling down a [shallow clone](http://stackoverflow.com/q/21833870) of the desired version's branch from [GitHub](https://github.com/raspberrypi/linux) (users with sufficient bandwidth and disk space may of course clone the entire tree, and then checkout the desired branch locally, but the following approach is much faster).

Working logged in as your regular user, _not_ root (for security), issue:
```console
user@pi64 ~ $ mkdir -pv kbuild && cd kbuild
user@pi64 kbuild $ rm -rf linux
user@pi64 kbuild $ git clone --depth 1 https://github.com/raspberrypi/linux.git -b rpi-4.10.y
```

This may take some time to complete, depending on the speed of your network connection.

When it has completed, go into the newly created `linux` directory, and set up the baseline `bcmrpi3_defconfig`:
```console
user@pi64 kbuild $  cd linux
user@pi64 linux $  make distclean
user@pi64 linux $  make bcmrpi3_defconfig
```

Next, modify the configuration if you like to suit your needs (this step is optional, as a kernel built with the stock `bcmrpi3_defconfig` will work perfectly well for most users):
```console
user@pi64 linux $  make menuconfig
```
When ready, go ahead and build the kernel, modules, included firmware and dtbs. Issue:
```console
user@pi64 linux $ nice -n 19 make -j4
```
This will a reasonable time to complete. (Incidentally, the build is forced to run at the lowest system priority, to prevent your machine becoming too unresponsive during this process.)

With the kernel built, we need to install it. Assuming your first microSD card partition is mounted as `/boot` (which, given the `/etc/fstab` on the image (visible [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/make.conf)), it should be), become root, and then, substituting your regular user's account name (the one you logged into when building the kernel, above) for `user` in the below, issue:
```console
pi64 ~ # cd /home/user/kbuild/linux
pi64 linux # cp -v arch/arm64/boot/Image /boot/kernel8.img
```
> Remember to back up your previous `/boot/kernel8.img` file before doing this, so you have a fallback in case there is an issue with your new kernel!

Note that by default, the kernel does _not_ require a separate U-Boot loader.

Next, copy over the device tree blobs (at the time of writing `arm64` was still using the `2710` dtb, but this may change to `2837` in future, so for safety, copy both):
```console
pi64 linux # cp -v arch/arm64/boot/dts/broadcom/bcm{2710,2837}-rpi-3-b.dtb /boot/
```

Lastly, install the modules and (kernel-created) firmware:
```console
pi64 linux # make modules_install
pi64 linux # make firmware_install
pi64 linux # sync
```

All done! After you reboot, you'll be using your new kernel.

It is also possible to cross-compile a kernel on your (Gentoo) PC, which is much faster than doing it directly on the RPi3. Please see the instructions [later in this document](#heavylifting).
> Alternatively, if you set up `distcc` with `crossdev` (also covered in the instructions [below](#heavylifting)), you can call `pump make` instead of `make` to automatically offload kernel compilation workload to your PC. However, if you do use `distcc` in this way, be aware that not all kernel files can be successfully built in this manner; a small number (particularly, at the start of the kernel build) may fall back to using local compilation. This is normal, and the vast majority of files _will_ distribute OK.


### Keeping Your Gentoo System Up-To-Date

You can update your system at any time. As there are quite a few steps involved to do this correctly on Gentoo, I have provided a convenience script, **genup** to do this as part of the image.
> **NB:** please be sure that you have an expanded root partition (as described [above](#morespace)) before attempting this: the update of certain installed packages (such as `www-client/firefox`) requires more free space than is present on the shipped image. A >=16GB microSD card (with an expanded root) is ideal.

So, to update your system, simply issue:
```console
pi64 ~ # genup
   (this will take some time to complete)
```
This is loosely equivalent to `apt-get update && apt-get upgrade` on Raspbian. See the [manpage](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/genup.pdf) for full details of the process followed, and the options available for the command.

Note that because Gentoo is a source-based distribution, and the RPi3 is not a *particularly* fast machine, updating may take a number of hours, if many packages have changed. However, `genup` will automatically take advantage of distributed cross-compiling, using `distcc`, if you have that set up (see [below](#heavylifting) for details).

> The image has the Gentoo automated signing key pre-installed, and will use the 'verified en bloc' method of downloading updates to the Portage tree (as described, for example, [here](https://wiki.gentoo.org/wiki/Sakaki%27s_EFI_Install_Guide/Using_Your_New_Gentoo_System_under_OpenRC#Switching_to_emerge-webrsync_for_Security_.28Optional.29)).

When the update has completed, if prompted to do so by genup, then issue:
```console
pi64 ~ # dispatch-conf
```
to deal with any config file clashes that may have been introduced by the upgrade process.

> Note that the **kernel** build process for Gentoo is separate (see the [previous section](#kernelbuild) for details).

For more information about Gentoo's package management, see [my notes here](https://wiki.gentoo.org/wiki/Sakaki's_EFI_Install_Guide/Installing_the_Gentoo_Stage_3_Files#Gentoo.2C_Portage.2C_Ebuilds_and_emerge_.28Background_Reading.29).

> You may also find it useful to keep an eye on the 'Gentoo on Alternative Architectures' forum at [gentoo.org](https://forums.gentoo.org/viewforum-f-32.html), as I occasionally post information about this project there.

## <a name="heavylifting"></a>Have your Gentoo PC Do the Heavy Lifting!

The RPi3 does not have a particularly fast processor when compared to a modern PC. While this is fine when running the device in day-to-day mode (as a IME-free lightweight desktop replacment, for example), it does pose a bit of an issue with a source-based distribution like Gentoo, where you must generally compile packages to upgrade them (unless an appropriately updated and trusted [binhost](https://wiki.gentoo.org/wiki/Binary_package_guide) is available). Everything works, but an upgrade of a significant package, like `www-client/firefox`, can take many hours, which soon gets tiresome.

However, there is a solution to this, and it is not as scary as it sounds - leverage the power of your PC (assuming it too is running Gentoo Linux) as a cross-compilation host!

For example, you can cross-compile kernels for your RPi3 on your PC very quickly (around 5-15 minutes from scratch), by using Gentoo's `crossdev` tool. See my full instructions [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Set-Up-Your-Gentoo-PC-for-Cross-Compilation-with-crossdev) and [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Build-an-RPi3-64bit-Kernel-on-your-crossdev-PC) on this project's open [wiki](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki).

Should you setup `crossdev` on your PC in this manner, you can then take things a step further, by leveraging your PC as a `distcc` server (instructions [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Set-Up-Your-crossdev-PC-for-Distributed-Compilation-with-distcc) on the wiki). Then, with just some simple configuration changes on your RPi3 (see [these notes](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Set-Up-Your-RPi3-as-a-distcc-Client)), you can distribute C/C++ compilation (and header preprocessing) to your remote machine, which makes system updates a lot quicker (and the provided tool `genup` will automatically take advantage of this distributed compilation ability, if available).

## Image binhost

I have made available a [Portage binhost](https://wiki.gentoo.org/wiki/Binary_package_guide) containing all the packages in this image, available at [http://isshoni.org/pi64](http://isshoni.org/pi64). You may find this useful (to save compilation time) if building your own 64-bit system from scratch. For most users, adding/uncommenting the following lines in `/etc/portage/make.conf` (on your Pi) will suffice to start using automatically the provided binary packages, where available (and building locally - as usual - where not):
```sh
PORTAGE_BINHOST="https://isshoni.org/pi64"
FEATURES="${FEATURES} getbinpkg"
```
See [these notes](https://wiki.gentoo.org/wiki/Binary_package_guide#Using_binary_packages) for more details. Use of the binhost is of course entirely optional: it is provided only as a convenience.
> I may add an automated update to this binhost in future, but as of the time of writing no such facility is in place.

## Acknowledgment

I'd like to acknowledge NeddySeagoon's work getting Gentoo to run in 64-bit mode on the RPi3 (see particularly [this thread](https://forums.gentoo.org/viewtopic-t-1041352.html), which was a really useful reference when putting this project together).

## Feedback Welcome!

If you have any problems, questions or comments regarding this project, feel free to drop me a line! (sakaki@deciban.com)
