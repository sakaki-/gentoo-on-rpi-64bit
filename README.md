# gentoo-on-rpi3-64bit
Bootable 64-bit Gentoo image for the Raspberry Pi 3 Model B and B+, with Linux 4.14, OpenRC, Xfce4, VC4, profile 17.0, weekly-autobuild binhost

## Description

<img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi3/Raspberry_Pi_3_B_and_B_plus.jpg" alt="Raspberry Pi 3 B and B+" width="250px" align="right"/>

This project is a bootable, microSD card **64-bit Gentoo image for the [Raspberry Pi 3 model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/) and [B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)** single board computers (SBC).
> A variant image for the [Pi-Top v1](https://pi-top.com/products/pi-top) (an RPi3-based DIY laptop) is also provided.

The image's userland contains a complete (OpenRC-based) Gentoo system (including a full Portage tree) - so you can run `emerge` operations immediately - and has been pre-populated with a reasonable package set (Xfce v4.13, LibreOffice v6.0.6.2, Firefox Quantum v61.0, Thunderbird v60.0, VLC v3.0.4, Kodi v17.4, GIMP v2.10.4 etc.) so that you can get productive *without* having to compile anything first (unless you want to, of course ^-^). As of version 1.2.0 of the image, all userland software has been built under Gentoo's 17.0 profile.

The kernel and userland are both 64-bit (`arm64`/`aarch64`), and support for the Pi's [VC4](https://wiki.gentoo.org/wiki/Raspberry_Pi_VC4) GPU has been included (using [`vc4-fkms-v3d`](https://www.raspberrypi.org/forums/viewtopic.php?f=29&t=159853) / Mesa), so rendering performance is reasonable (e.g., `glxgears` between 400 and 1200fps, depending on load; real-time video playback). The Pi's onboard Ethernet, WiFi (dual-band on the RPi3 B+) and Bluetooth adaptors are supported, as is the official 7" [touchscreen](#touchscreen) (if you have one). Sound works too, both via HDMI (given an appropriate display), and the onboard headphone jack. As of version 1.1.0 of the image, a [weekly-autobuild binhost](#binhost), custom [Gentoo profile](#profile), and [binary kernel package](#binary_kp) have been provided, making it relatively painless to keep your system up-to-date (and, because of this, [`genup`](https://github.com/sakaki-/genup) has been configured to run [automatically once per week](#weekly_update), by default).

Here's a screenshot:

<img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi3/demo-screenshot-small-3.jpg" alt="gentoo-on-rpi3-64bit in use (screenshot)" width="960px"/>

The image may be downloaded from the link below (or via `wget`, per the instructions which follow).

<a id="downloadlinks"></a>Variant | Version | Image | Digital Signature
:--- | ---: | ---: | ---:
Raspberry Pi 3 Model B or B+ 64-bit | v1.3.0 | [genpi64.img.xz](https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.3.0/genpi64.img.xz) | [genpi64.img.xz.asc](https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.3.0/genpi64.img.xz.asc)
Pi-Top (an RPi3-based DIY Laptop) 64-bit | v1.3.0 | [genpi64pt.img.xz](https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.3.0/genpi64pt.img.xz) | [genpi64pt.img.xz.asc](https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.3.0/genpi64pt.img.xz.asc)

**NB:** most users will want the first ([genpi64.img.xz](https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.3.0/genpi64.img.xz)) image - the Pi-Top variant ([genpi64pt.img.xz](https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.3.0/genpi64pt.img.xz)) should *only* be used for those who want to run their RPi3 in a [Pi-Top](https://pi-top.com/products/pi-top) chassis (as it contains platform-specific drivers to communicate with the Pi-Top's onboard battery, hub, speakers etc.)

> The previous release versions are still available (together with a detailed changelog) [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases). If you have a significant amount of work invested in an older release of this image, I have also provided manual upgrade instructions (from 1.0.0 thru 1.2.2 &rarr; 1.3.0) [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases#upgrade_to_1_3_0).

Please read the instructions below before proceeding. Also please note that all images (and binary packages) are provided 'as is' and without warranty. You should also be comfortable with the (at the moment, unavoidable) non-free licenses required by the firmware and boot software supplied on the image before proceeding: these may be reviewed [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/tree/master/licenses).

> It is sensible to install Gentoo to a **separate** microSD card from that used by your default Raspbian system; that way, when you are finished using Gentoo, you can simply power off, swap back to your old card, reboot, and your original system will be just as it was.

> Please also note that support for `arm64` is still in its [early stages](https://wiki.gentoo.org/wiki/Raspberry_Pi) with Gentoo, so it is quite possible that you may encounter strange bugs etc. when running a 64-bit image such as this one. A lot of packages [have been `* ~*` keyworded](https://github.com/sakaki-/rpi3-overlay/tree/master/profiles/targets/rpi3/package.accept_keywords) to get the system provided here to build... but hey, if you like Gentoo, little things like that aren't likely to put you off ^-^

## Table of Contents

- [Prerequisites](#prerequisites)
- [Downloading and Writing the Image](#downloading-and-writing-the-image)
  * [Regular Image (genpi64.img.xz)](#regular-image-genpi64imgxz)
  * [Pi-Top Image (genpi64pt.img.xz)](#pi-top-image-genpi64ptimgxz)
- [Booting!](#booting)
- [Using Gentoo](#using-gentoo)
- [Keeping Your System Up-To-Date](#keeping-your-system-up-to-date)
  * [Installing New Packages Under Gentoo](#installing-new-packages-under-gentoo)
- [Miscellaneous Configuration Notes, Hints, and Tips](#miscellaneous-configuration-notes-hints-and-tips-skip)
- [Maintenance Notes (Advanced Users Only)](#maintenance-notes-advanced-users-only-skip)
  * [Optional: Switch Back to a 'Pure' bcmrpi3_defconfig Kernel](#optional-switch-back-to-a-pure-bcmrpi3_defconfig-kernel)
  * [Optional: Compiling a Kernel from Source](#optional-compiling-a-kernel-from-source)
  * [Have your Gentoo PC Do the Heavy Lifting!](#have-your-gentoo-pc-do-the-heavy-lifting)
  * [Using your RPi3 as a Headless Server](#using-your-rpi3-as-a-headless-server)
- [Miscellaneous Points (Advanced Users Only)](#miscellaneous-points-advanced-users-only-skip)
  * [RPi3-Specific Ebuilds](#rpi3-specific-ebuilds)
  * [New Features to Expedite Regular System Updating](#new-features-to-expedite-regular-system-updating)
  * [Subscribed Ebuild Repositories (aka Overlays)](#subscribed-ebuild-repositories-aka-overlays)
- [Help Wanted!](#help-wanted)
- [Acknowledgement](#acknowledgement)
- [Feedback Welcome!](#feedback-welcome)

## Prerequisites

To try this out, you will need:
* A [microSD](https://en.wikipedia.org/wiki/Secure_Digital) card of _at least_ 8GB capacity (the image is 1,241MiB compressed, 7.31GiB == 7.85GB uncompressed, so it should fit on any card marked as >= 8GB). If you intend to build large packages (or kernels) on your RPi3, a card of >=16GB is **strongly** recommended (the root partition will [automatically be expanded](#morespace) to fill the available space on your microSD card, on first boot). Depending on the slots available on your PC, you may also need an adaptor to allow the microSD card to be plugged in (to write the image to it initially).
   > I have found most SanDisk cards work fine; if you are having trouble, a good sanity check is to try writing the [standard Raspbian 32-bit image](https://www.raspberrypi.org/downloads/raspbian/) to your card, to verify that your Pi3 will boot with it, before proceeding.

* A Raspberry Pi 3 Model B or B+ (obviously!). (Or, a Pi-Top, if you are using that variant of the image.)
For simplicity, I am going to assume that you will be logging into the image (at least initially) via an (HDMI) screen and (USB) keyboard connected directly to your Pi, rather than e.g. via `ssh` (although, for completeness, it *is* possible to `ssh` in via the Ethernet interface (which has a DHCP client running), if you can determine the allocated IP address, for example from your router, or via [`nmap`](https://security.stackexchange.com/a/36200)).
A [decent power supply](https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=138636) is recommended.

* A PC to decompress the image and write it to the microSD card. This is most easily done on a Linux machine of some sort, but it is straightforward on a Windows or Mac box too (for example, by using [Etcher](https://etcher.io), which is a nice, all-in-one cross-platform graphical tool for exactly this purpose; it's free and open-source). In the instructions below I'm going to assume you're using Linux.
   > It is possible to use your Raspberry Pi for this task too, if you have an external card reader attached, or if you have your root on e.g. USB (and take care to unmount your existing /boot directory before removing the original microSD card), or are booted directly from USB. Most users will find it simplest to write the image on a PC, however.

## Downloading and Writing the Image

Choose either the regular (for a standard RPi3 board) or Pi-Top variant, then follow the appropriate instructions below ([regular](#regularimage) or [Pi-Top](#pitopimage)).

> If you are using a Windows or Mac box, or prefer to use a GUI tool in Linux, I recommend you download your preferred image via your web browser using the [links](#downloadlinks) above, and then check out the free, open-source, cross-platform tool [Etcher](https://etcher.io) to write it to microSD card. Then, once you've done that, continue reading at ["Booting!"](#booting) below.

> Alternatively, for those who prefer the Raspberry Pi [NOOBS](https://www.raspberrypi.org/documentation/installation/noobs.md) installer GUI, both images are now available for installation using [PINN](https://github.com/procount/pinn). PINN is a fork of NOOBS and includes a number of additional advanced features. Please see [this post](https://forums.gentoo.org/viewtopic-p-8122236.html#8122236) for further details. *Many thanks to [procount](https://github.com/procount) for his work on this.*

### <a id="regularimage"></a>Regular Image (`genpi64.img.xz`)

On your Linux box, issue (you may need to be `root`, or use `sudo`, for the following, hence the '#' prompt):
```console
# wget -c https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.3.0/genpi64.img.xz
# wget -c https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.3.0/genpi64.img.xz.asc
```

<img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi3/Raspberry_Pi_3_B_and_B_plus.jpg" alt="Raspberry Pi 3 B and B+" height="200px" align="right"/>

to fetch the compressed disk image file (~1,241MiB) and its signature.

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

The above `xzcat` to the microSD card will take some time, due to the decompression (it takes between 10 and 25 minutes on my machine, depending on the microSD card used). It should exit cleanly when done - if you get a message saying 'No space left on device', then your card is too small for the image, and you should try again with a larger capacity one.
> <a id="morespace"></a>Note that on first boot, the image will _automatically_ attempt to resize its root partition (which, in this image, includes `/home`) to fill all remaining free space on the microSD card, by running [this startup service](https://github.com/sakaki-/rpi3-overlay/blob/master/sys-apps/rpi3-init-scripts/files/init.d_autoexpand_root-4); if you _do not_ want this to happen (for example, because you wish to add extra partitions to the microSD card later yourself), then simply **rename** the (empty) sentinel file `autoexpand_root_partition` (in the top level directory of the `vfat` filesystem on the first partition of the microSD card) to `autoexpand_root_none`, before attempting to boot the image for the first time.

Now continue reading at ["Booting!"](#booting) below.

### <a id="pitopimage"></a>Pi-Top Image (`genpi64pt.img.xz`)

> Please note that only v1 of the Pi-Top is currently supported (although you *are* free to use an RPi3 B *or* B+ within the v1 chassis, at your option). The image *may* work on v2 hardware (the one with the sliding keyboard), but as I don't currently own this newer model, I am unable to check. If you have tried booting this image on a v2 Pi-Top, please let me know how it went. Thanks!

On your Linux box, issue (you may need to be `root`, or use `sudo`, for the following, hence the '#' prompt):
```console
# wget -c https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.3.0/genpi64pt.img.xz
# wget -c https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/download/v1.3.0/genpi64pt.img.xz.asc
```

<img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi3/pitop/gentoo-pitop-small.jpg" alt="Pi-Top Running Gentoo" height="200px" align="right"/>

to fetch the compressed disk image file (~1,241MiB) and its signature.

Next, if you like, verify the image using gpg (this step is optional):
```console
# gpg --keyserver pool.sks-keyservers.net --recv-key DDE76CEA
# gpg --verify genpi64pt.img.xz.asc genpi64pt.img.xz
```

Assuming that reports 'Good signature', you can proceed. (Warnings that the key is "not certified with a trusted signature" are normal and [may be ignored](http://security.stackexchange.com/questions/6841/ways-to-sign-gpg-public-key-so-it-is-trusted).)

Next, insert (into your Linux box) the microSD card on which you want to install the image, and determine its device path (this will be something like `/dev/sdb`, `/dev/sdc` etc. (if you have a [USB microSD card reader](http://linux-sunxi.org/Bootable_SD_card#Introduction)), or perhaps something like `/dev/mmcblk0` (if you have e.g. a PCI-based reader); in any case, the actual path will depend on your system - you can use the `lsblk` tool to help you). Unmount any existing partitions of the card that may have automounted (using `umount`). Then issue:

> **Warning** - this will *destroy* all existing data on the target drive, so please double-check that you have the path correct! As mentioned, it is wise to use a spare microSD card as your target, keeping your existing Raspbian microSD card in a safe place; that way, you can easily reboot back into your existing Raspbian system, simply by swapping back to your old card.

```console
# xzcat genpi64pt.img.xz > /dev/sdX && sync
```

Substitute the actual microSD card device path, for example `/dev/sdc`, for `/dev/sdX` in the above command. Make sure to reference the device, **not** a partition within it (so e.g., `/dev/sdc` and not `/dev/sdc1`; `/dev/sdd` and not `/dev/sdd1` etc.)
> If, on your system, the microSD card showed up with a path of form `/dev/mmcblk0` instead, then use this as the target, in place of `/dev/sdX`. For this naming format, the trailing digit *is* part of the drive name (partitions are labelled as e.g. `/dev/mmcblk0p1`, `/dev/mmcblk0p2` etc.). So, for example, you might need to use `xzcat genpi64pt.img.xz > /dev/mmcblk0 && sync`.

The above `xzcat` to the microSD card will take some time, due to the decompression (it takes between 10 and 25 minutes on my machine, depending on the microSD card used). It should exit cleanly when done - if you get a message saying 'No space left on device', then your card is too small for the image, and you should try again with a larger capacity one.
> Note that on first boot, the image will _automatically_ attempt to resize its root partition (which, in this image, includes `/home`) to fill all remaining free space on the microSD card, by running [this startup service](https://github.com/sakaki-/rpi3-overlay/blob/master/sys-apps/rpi3-init-scripts/files/init.d_autoexpand_root-4); if you _do not_ want this to happen (for example, because you wish to add extra partitions to the microSD card later yourself), then simply **rename** the (empty) sentinel file `autoexpand_root_partition` (in the top level directory of the `vfat` filesystem on the first partition of the microSD card) to `autoexpand_root_none`, before attempting to boot the image for the first time.

Now continue reading at ["Booting!"](#booting), immediately below.

## <a id="booting"></a>Booting!

Begin with your RPi3 powered off. Remove the current (Raspbian or other) microSD card from the board (if fitted), and store it somewhere safe.

Next, insert the (Gentoo) microSD card you just wrote the image to into the Pi. Apply power.

You should see the RPi3's standard 'rainbow square' on-screen for about 2 seconds, then the display will go blank for about 10 seconds, and then (once the graphics driver has loaded) a text console will appear, showing OpenRC starting up. On this first boot (unless you have renamed the sentinel file `autoexpand_root_partition` in the microSD card's first partition to `autoexpand_root_none`), the system will, after a further 10 seconds or so, _automatically resize_ the root partition to fill all remaining free space on the drive, and, having done this, reboot (to [allow the kernel to see](http://unix.stackexchange.com/questions/196435/is-it-possible-to-enlarge-the-partition-without-rebooting) the new partition table). You should then see the 'rainbow square' startup sequence once more, and then the system will resize its root filesystem, to fill the newly enlarged partition, and create an empty 1,024MiB swapfile (space permitting). Once this is done, it will launch a standard Xfce desktop (logged in automatically to the pre-created `demouser` account):

<img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi3/xfce-desktop-small-2.png" alt="Baseline Xfce desktop" width="960px"/>

The whole process (from first power on to graphical desktop) should take less than **three minutes** or so. **Please be patient during this first-time startup**; on subsequent reboots, the resizing and swapfile creation processes will not run, so your system will come up a _lot_ faster.

> The initial **root** password on the image is **raspberrypi64**. The password for **demouser** is also **raspberrypi64** (you may need this if e.g. the screen lock comes on; you can also do `sudo su --login root` to get a root prompt at the terminal, without requiring a password). These passwords are set by the [`autoexpand-root`](https://github.com/sakaki-/rpi3-overlay/blob/master/sys-apps/rpi3-init-scripts/files/init.d_autoexpand_root-4) startup service. Note that the screensaver for `demouser` has been disabled by default on the image.

> NB - if your connected computer monitor or TV output appears **flickering or distorted**, you may need to change the settings in the file `config.txt`, located in the microSD card's first partition (this partition is formatted `vfat` so you should be able to edit it on any PC; alternatively, when booted into the image, it is available at `/boot/config.txt`). Any changes made take effect on the next restart. For an explanation of the various options available in `config.txt`, please see [these notes](https://www.raspberrypi.org/documentation/configuration/config-txt/README.md) (the [shipped defaults](https://github.com/sakaki-/rpi3-overlay/blob/master/sys-boot/rpi3-64bit-firmware/files/config.txt-2) should work fine for most users, however).

> If the **edges of the desktop appear "clipped" by your display** (this mostly happens when using HDMI TVs), issue `sudo mousepad /boot/config.txt`, comment out the line `disable_overscan=1` (so it reads instead `#disable_overscan=1`), save the file, and then reboot.

## <a id="using_gentoo"></a>Using Gentoo

The supplied image contains a fully-configured `~arm64` Gentoo system (*not* simply a [minimal install](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Media#Minimal_installation_CD) or [stage 3](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Media#What_are_stages_then.3F)), with a complete Portage tree already downloaded, so you can immediately perform `emerge` operations etc. Be aware that, as shipped, it uses **UK locale settings, keyboard mapping, timezone and WiFi regulatory domain**; however, these are easily changed if desired. See the Gentoo Handbook ([here](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Base#Timezone) and [here](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/System#Init_and_boot_configuration)) for details on the first three; to customize the WiFi regulatory domain, enter the appropriate [two-letter IEC 3166 country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Decoding_table) within the file `/etc/conf.d/rpi3-wifi-regdom` (the shipped value is `WIFI_REGDOM="GB"`), and reboot.

If you wish to add Bluetooth peripherals (e.g., a wireless mouse and/or keyboard) to your RPi3, please see [below](#add_bt_device).

If you would like to run **benchmarks** on your RPi3 system, please see [these notes](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Effective-Benchmarking-on-your-64-Bit-RPi3-System).

The `@world` set of packages (from `/var/lib/portage/world`) pre-installed on the image may be viewed [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/world-packages) (note that the version numbers shown in this list are Gentoo ebuilds, but they generally map 1-to-1 onto upstream package versions).
> The *full* package list for the image (which includes @system and dependencies) may also be viewed, [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/world-all-packages).

The system on the image has been built via a minimal install system and stage 3 from Gentoo (`arm64`, available [here](http://distfiles.gentoo.org/releases/arm/autobuilds/current-stage3-arm64/)), but _all_ binaries (libraries and executables) have been rebuilt (with profile 17.0) to target the Raspberry Pi 3 B/B+'s BCM2837 SoC specifically (the `/etc/portage/make.conf` file used on the image may be viewed [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/make.conf), augmented by the [custom profile's](#profile) [`make.defaults`](https://github.com/sakaki-/rpi3-overlay/tree/master/profiles/targets/rpi3/make.defaults)). The CHOST on the image is `aarch64-unknown-linux-gnu` (per [these notes](https://wiki.gentoo.org/wiki/User:NeddySeagoon/Pi3#Getting_Started)). All packages have been brought up to date against the Gentoo tree as of 16 September 2018.

> Note: the CFLAGS used for the image build is `-march=armv8-a+crc -mtune=cortex-a53 -O2 -pipe`. You can of course re-build selective components with more aggressive flags yourself, should you choose. As the SIMD FPU features are standard in ARMv8, there is no need for `-mfpu=neon mfloat-abi=hard` etc., as you would have had on e.g. the 32-bit ARMv7a architecture. Note that AArch64 NEON also has a full IEEE 754-compliant mode (including handling denormalized numbers etc.), there is also no need for `-ffast-math` flag to fully exploit the FPU either (again, unlike earlier ARM systems). Please refer to the official [Programmer’s Guide for ARMv8-A](http://infocenter.arm.com/help/topic/com.arm.doc.den0024a/DEN0024A_v8_architecture_PG.pdf) for more details.

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
pi64 ~ # useradd --create-home --groups "adm,disk,lp,wheel,audio,video,cdrom,usb,users,plugdev,portage,cron" --shell /bin/bash --comment "Sakaki" sakaki
pi64 ~ # passwd sakaki
New password: <type your desired password for the new user, and press Enter>
Retype new password: <type the desired password again, and press Enter>
passwd: password updated successfully
```

You can then log out of `demouser`, and log into your new account, using the username and password just set up. When prompted with the `Welcome to the first start of the panel` dialog, select <kbd>Use default config</kbd>, as this provides a useful 'starter' layout.

> <a id="black_background_first_login"></a>Depending on how quickly you select <kbd>Use default config</kbd>, you *may* find you are left with a black desktop background. This issue should resolve itself after your next login, however.

Then, once logged in, you can delete the `demouser` account if you like. Open a terminal, `su` to root, then:
```console
pi64 ~ # userdel --remove demouser
userdel: demouser mail spool (/var/spool/mail/demouser) not found
```
> The mail spool warning may safely be ignored. Also, if you want your new user to be automatically logged in on boot (as `demouser` was), substitute your new username for `demouser` in the file `/etc/lightdm/lightdm.conf.d/50-autologin-demouser.conf` (and if you do _not_ want autologin, this file may safely be deleted).

One hint worth bearing in mind: desktop compositing is on for new users by default. This gives nicely rendered window shadows etc. but if you find video playback framerates (from `VLC`, `SMPlayer` etc.) are too slow, try turning it off (<kbd>Applications</kbd>&rarr;<kbd>Settings</kbd>&rarr;<kbd>Window Manager Tweaks</kbd>, <kbd>Compositor</kbd> tab).

> Note that as of version 1.1.2 of the image, a number of Xfce 'fixups' will automatically be applied when a new user logs in for the first time; these include:<br>1) synchronizing compositing to the vertical blank (without which menus flash annoyingly under VC4);<br>2) setting window move and resize opacity levels; and<br>3) ensuring the desktop background displays on login (otherwise it often stays black; note that this fix sometimes does not work for the *first* login of a new user, as noted [above](black_background_first_login)).<br>They are managed by the `xfce-extra/xfce4-fixups-rpi3` package (which inserts an entry into `/etc/xdg/autostart/`).

## <a id="weekly_update"></a>Keeping Your System Up-To-Date

You can update your system at any time. As there are quite a few steps involved to do this correctly on Gentoo, I have provided a convenience script, `genup` ([source](https://github.com/sakaki-/genup), [manpage](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/genup.pdf)) to do this as part of the image.

Note that **by [default](#why_weekly_update), this script will run automatically once per week, commencing the second week after first boot** (see the task installed in `/etc/cron.weekly`). Review the logfile `/var/log/latest-genup-run.log` to see changes made by the latest auto-update run.

> As of version 1.3.0 of the image, a number of additional 'fixups' will also be applied weekly - these are small scripts (which may be viewed [here](https://github.com/sakaki-/rpi3-overlay/tree/master/app-portage/weekly-genup/files)) used to address emergent issues that e.g. may prevent your system updating correctly. The output may be reviewed in `/var/log/latest-fixup-run.log`. Disabling auto-updating (see text immediately below) will also disable the fixup cronjob.

<a id="disable_weekly_update"></a>If you would rather _not_ use auto-updating, simply edit the file `/etc/portage/package.use/rpi3-64bit-meta` so it reads (the relevant line is the last one):
```bash
# enable/disable any metapackage USE flags you want here, and then
# re-emerge dev-embedded/rpi3-64bit-meta to have the effect taken up
# e.g.:
#
#    dev-embedded/rpi3-64bit-meta -weekly-genup -porthash
#
# (uncommented) to disable the automated weekly genup (package update)
# run, and to disable the requirement for a signature check on the
# isshoni.org rsync mirror
#
# unless you so specify, we accept all existing default metapackage flags:
# at the time of writing, those were (default flag status shown as + or -):
#
#  + boot-fw : pull in the /boot firmware, configs and bootloader
#  + kernel-bin : pull in the binary kernel package
#  - porthash : pull in repo signature checker, for isshoni.org rsync
#  + weekly-genup: pull in cron.weekly script, to run genup automatically
#  + core: pull in core system packages for image (sudo etc.)
#  + xfce: pull in packages for baseline Xfce4 system (requires core)
#  - pitop: pull in Pi-Top support packages (NB most users will NOT want this;
#      the Pi-Top is a DIY laptop kit based around the RPi3) (requires xfce)
#  - apps: pull in baseline desktop apps (libreoffice etc.) (requires xfce)
#
# NB the main point of the core, xfce, pitop and apps USE flags is just to let
# you reduce what is in your @world set (/var/lib/portage/world).
dev-embedded/rpi3-64bit-meta -weekly-genup
```

Then re-emerge the meta package, which will remove the `cron` entry (NB: doing it this way ensures the entry *stays* removed, even if you later manually update your system):
```console
pi64 ~ # emerge -v rpi3-64bit-meta
```

Of course, you can always use `genup` directly (as root) to update your system at any time. See the [manpage](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/genup.pdf) for full details of the process followed, and the options available for the command.

> Bear in mind that a `genup` run will take around one to two hours to complete, even if all the necessary packages are available as binaries on the [binhost](#binhost). Why? Well, since Gentoo's [Portage](https://wiki.gentoo.org/wiki/Portage) - unlike most package managers - gives you the flexibility to specify which package versions and configuration (via USE flags) you want, it has a nasty graph-theoretic problem to solve each time you ask to upgrade (and it is mostly written in Python too, which doesn't help ^-^). Also, many of the binary packages are themselves quite large (for example, the current `libreoffice` binary package is ~100MiB) and so time-consuming to download (unless you have a very fast Internet connection).

When an update run has completed, if prompted to do so by genup (directly, or at the tail of the `/var/log/latest-genup-run.log` logfile), then issue:
```console
pi64 ~ # dispatch-conf
```
to deal with any config file clashes that may have been introduced by the upgrade process.

> Note for Pi-Top variant users: if you are wondering about the `pitop` USE flag, it is set globally, in `/etc/portage/make.conf` on your image, rather than in `/etc/portage/package.use/rpi3-64bit-meta`, as it affects a number of packages.

For more information about Gentoo's package management, see [my notes here](https://wiki.gentoo.org/wiki/Sakaki's_EFI_Install_Guide/Installing_the_Gentoo_Stage_3_Files#Gentoo.2C_Portage.2C_Ebuilds_and_emerge_.28Background_Reading.29).

> You may also find it useful to keep an eye on this project's (sticky) thread in the 'Gentoo on ARM' forum at [gentoo.org](https://forums.gentoo.org/viewtopic-t-1058530.html), as I occasionally post information about this project there.

### Installing New Packages Under Gentoo

> The following is only a *very* brief intro to get you started. For more information, see the [Gentoo handbook](https://wiki.gentoo.org/wiki/Handbook:AMD64/Working/Portage).

You can add any additional packages you like to your RPi3. To search for available packages, you can use the (pre-installed) [`eix` tool](https://wiki.gentoo.org/Eix). For example, to search for all packages with 'hex editor' in their description:

```console
demouser@pi64 ~ $ eix --description --compact "hex.editor"
[N] app-editors/curses-hexedit (--): full screen curses hex editor (with insert/delete support)
[N] app-editors/dhex (--): ncurses-based hex-editor with diff mode
[N] app-editors/hexcurse (--): ncurses based hex editor
[N] app-editors/lfhex (--): A fast hex-editor with support for large files and comparing binary files
[N] app-editors/qhexedit2 (--): Hex editor library, Qt application written in C++ with Python bindings
[N] app-editors/shed (--): Simple Hex EDitor
[N] app-editors/wxhexeditor (--): A cross-platform hex editor designed specially for large files
[N] dev-util/bless (--): GTK# Hex Editor
Found 8 matches
```
(your output may vary).

Then, suppose you wanted to find out more about one of these, say `shed`:

```console
demouser@pi64 ~ $ eix --verbose app-editors/shed
* app-editors/shed
     Available versions:  *1.12 *1.13 ~*1.15
     Homepage:            http://shed.sourceforge.net/
     Find open bugs:      https://bugs.gentoo.org/buglist.cgi?quicksearch=app-editors%2Fshed
     Description:         Simple Hex EDitor
     License:             GPL-2

```
(again, your output may vary, depending upon the state of the Gentoo repo at the time you run the query, your version of `eix`, etc.)

That '\*' in front of versions 1.12 and 1.13 indicates that the package has *not* yet been reviewed by the Gentoo devs for the `arm64` architecture, but that its versions 1.12 and 1.13 *have* been reviewed as stable for some other architectures (in this case, `amd64`, `ppc` and `x86` - you can see this by reviewing the matching ebuilds, at `/usr/portage/app-editors/shed/shed-1.12.ebuild` and `/usr/portage/app-editors/shed/shed-1.13.ebuild`). Version 1.15 is also marked as being in testing (the '\~\*') for those (other) architectures.

However, you will find that most packages (which don't have e.g. processor-specific assembly or 32-bit-only assumptions) *will* build fine on `arm64` anyway, you just need to tell Gentoo that it's OK to try.

To do so for this package, become root, then issue:

```console
pi64 ~ # echo "app-editors/shed * ~*" >> /etc/portage/package.accept_keywords/shed
```

> The above means to treat as an acceptable build candidate any version marked as *stable* on any architecture (the '*\') or as *testing* on any architecture (the '\~\*'). The second does *not* imply the first - for example, `shed-1.12` is not marked as testing on any architecture at the time of writing, so just '~\*' wouldn't match it.

Then you can try installing it, using [`emerge`](https://wiki.gentoo.org/wiki/Portage):
```console
pi64 ~ # emerge --verbose app-editors/shed

These are the packages that would be merged, in order:

Calculating dependencies... done!
[ebuild  N    *] app-editors/shed-1.15::gentoo  86 KiB

Total: 1 package (1 new), Size of downloads: 86 KiB

>>> Verifying ebuild manifests
>>> Emerging (1 of 1) app-editors/shed-1.15::gentoo
>>> Installing (1 of 1) app-editors/shed-1.15::gentoo
>>> Recording app-editors/shed in "world" favorites file...
>>> Jobs: 1 of 1 complete                           Load avg: 1.25, 0.56, 0.21
>>> Auto-cleaning packages...

>>> No outdated packages were found on your system.

 * GNU info directory index is up-to-date.
```

Once this completes, you can use your new package!

> Note that if you intend to install complex packages, you may find it easier to set `ACCEPT_KEYWORDS="* ~*"` in `/etc/portage/make.conf`, since many packages are not yet keyworded for `arm64` yet on Gentoo. Obviously, this will throw up some false positives, but it will also mostly prevent Portage from suggesting you pull in 'live' (aka `-9999`) ebuilds, which can easily create a nasty dependency tangle.

Once you get a package working successfully, you can then explicitly keyword its dependencies if you like (in `/etc/portage/package.accept_keywords/...`), rather than relying on `ACCEPT_KEYWORDS="* ~*"` in `/etc/portage/make.conf`. Should you do so, please feel free to file a PR against the [`rpi3:default/linux/arm64/17.0/desktop/rpi3` profile](https://github.com/sakaki-/rpi3-overlay/tree/master/profiles/targets/rpi3) with your changes, so that others can benefit (I intend to submit keywords from this profile to be considered for inclusion in the main Gentoo tree, in due course).

Have fun! ^-^

> If you need to install a particular package that isn't currently in the Gentoo tree, note that it _is_ possible to install binary packages from Raspbian (or other 32-bit repos) on your 64-bit system. For further details, please see [these notes](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Running-32-bit-Raspbian-Packages-on-your-64-bit-Gentoo-System).

> Alternatively, to install source packages with highly resource-intensive build profiles (such as `dev-lang/rust`), you can temporarily mount the image within a `binfmt_misc` QEMU user-mode `chroot` on your Linux PC, and perform the `emerge` there. This technique allows you to easily leverage the increased memory and CPU throughput of your regular desktop machine. For further details, please see my wiki tutorial [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Build-aarch64-Packages-on-your-PC%2C-with-User-Mode-QEMU-and-binfmt_misc).

## Miscellaneous Configuration Notes, Hints, and Tips (&darr;[skip](#maintnotes))

You don't need to read the following notes to use the image, but they may help you better understand what is going on!

* For simplicity, the image uses a single `ext4` root partition (includes `/home`), which [by default](#morespace) will be auto-resized to fill all remaining free space on the microSD card on first boot. Also, to allow large packages (such as `gcc`) to be built from source without running out of memory, a 128 MiB swapfile has been set up at `/var/cache/swap/swap1`, and on first boot this will be auto-expanded to 1,024 MiB, free space permitting (by [this service](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-apps/rpi3-expand-swap)). Feel free to modify this configuration as desired (for example, you can significantly improve performance under load by setting up a dedicated swap device on a separate bus from the system's rootfs; for details, please see [this short tutorial](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Improve-Swap-Perfomance-on-your-RPi3)).
   > Incidentally, it *is* possible to get an RPi3 Model B to boot from a USB drive (no microSD card required); see for example [these instructions](http://www.makeuseof.com/tag/make-raspberry-pi-3-boot-usb/) (try at your own risk!), and furthermore the RPi3 Model B+ can boot a USB-written image _without_ modification, as it has the necessary OTP fuses factory-set. Alternatively, you can retain `/boot` on the microSD card, but use a USB drive for the system root (remember to modify `/boot/cmdline.txt` and `/etc/fstab` accordingly, if you choose to go this route).

* As of version 1.3.0 of the image, the [`zswap`](https://en.wikipedia.org/wiki/Zswap) in-memory transparent compressing swap cache is in use. Under most normal workloads, this should improve responsiveness when the system starts to run out of memory, by intercepting swapped-out memory pages, compressing them, and storing them in a dynamic RAM buffer instead. The `rpi3-zswap` service may be viewed [here](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-apps/rpi3-zswap), and configured via [`/etc/conf.d/rpi3-zswap`](https://github.com/sakaki-/rpi3-overlay/blob/master/sys-apps/rpi3-zswap/files/conf.d_rpi3-zswap-1). 

* Because the Pi has no battery-backed real time clock (RTC), I have used the `swclock` (rather than the more usual `hwclock`) OpenRC boot service on the image - this simply sets the clock on boot to the recorded last shutdown time. An NTP client, `chronyd`, is also configured, and this will set the correct time as soon as a valid network connection is established.
   > Note that this may cause a large jump in the time when it syncs, which in turn will make the screensaver lock come on. Not a major problem, but something to be aware of, as it can be quite odd to boot up, log in, and have your screen almost immediately lock! For this reason, the `demouser` account on the image has the screensaver disabled by default.

* The image is configured with `NetworkManager`, so achieving network connectivity should be straightforward. The Ethernet interface is initially configured as a DHCP client, but obviously you can modify this as needed. Use the NetworkManager applet (top right of your screen) to do this; you can also use this tool to connect to a WiFi network.
   > Note that getting WiFi to work on the RPi3 requires appropriate firmware (installed in `/lib/firmware/brcm`): this is managed by the `sys-firmware/brcm43430-firmware` package (see [below](#wifi)). On the RPi3 B+, dual-band WiFi is supported.

* Bluetooth *is* operational on this image, but since, by default, the Raspberry Pi 3 [uses the hardware UART](http://www.briandorey.com/post/Raspberry-Pi-3-UART-Overlay-Workaround) / `ttyAMA0` to communicate with the Bluetooth adaptor, the standard serial console does not work and has been disabled on this image (see `/etc/inittab` and `/boot/cmdline.txt`). You can of course [change this behaviour](https://www.raspberrypi.org/forums/viewtopic.php?t=138120) if access to the hardware serial port is important to you.
   > Bluetooth on the RPi3 also requires a custom firmware upload. This is carried out by a the `rpi3-bluetooth` OpenRC service, supplied by the `net-wireless/rpi3-bluetooth` package (see [below](#bluetooth)).
   
   * **Tip:** <a id="add_bt_device"></a>to connect a new Bluetooth device to your RPi3 (a wireless mouse or keyboard, for example), first click on the Bluetooth icon in the top toolbar. When the `Bluetooth Devices` panel opens, click on <kbd>Search</kbd>, and make your device discoverable (this will usually involve pressing or holding a button or switch on the device itself), shortly after which it should appear in the listing. Once it does, click on it, then press <kbd>Setup...</kbd>, then ensure the `Pair Device` radio button is selected, and click <kbd>Next</kbd>. Then, if you are attaching a more complex device such as a keyboard, you'll see a PIN code notification message displayed (simpler devices, such as mice, often don't require a PIN for pairing, in which case no message will show). If you *are* prompted with a PIN, enter the code given into your device (for a keyboard, this normally means typing it in and pressing <kbd>Enter</kbd>). Once the devices are paired, you'll be prompted where to connect the device to: ensure the `Human Interface Device Service (HID)` radio button is selected, and click <kbd>Next</kbd>. Hopefully you will then see a message telling you `Device added and connected successfully`; click <kbd>Close</kbd> to dismiss it. With this done, your new device should start working. However, if you want to have it connect again automatically each boot, there's one more step you need to do. Click on your new device in the list (its icon should now be showing a key symbol, indicating that it is paired), and then click on the <kbd>Trust</kbd> shortcut button (the one that looks like a four-pointed gold star). With this done, your device setup is complete! You can add multiple interface devices to your RPi3 in this manner.

* The Pi3 uses the first (`vfat`) partition of the microSD card (`/dev/mmcblk0p1`) for booting. The various (closed-source) firmware files pre-installed there may are managed by the `sys-boot/rpi3-64bit-firmware` package (see [below](#boot_fw)). Once booted, this first partition will be mounted at `/boot`, and you may wish to check or modify the contents of the files `/boot/cmdline.txt` and `/boot/config.txt`.

* Because of licensing issues (specifically, [`bindist`](https://packages.gentoo.org/useflags/bindist) compliance), Mozilla Firefox Quantum has been distributed in its 'developer' edition - named 'Aurora'. Bear in mind that this app will take quite a long time (20 to 30 seconds) to start on first use, as it sets up its local storage in `~/.mozilla/<...>`.
   * I have also pre-installed the lighter-weight Links browser on the image, in case you would like to use this in preference to Firefox.
   * For additional security, you can consider running Firefox inside an X11 `firejail` sandbox. See [these notes](https://wiki.gentoo.org/wiki/Sakaki%27s_EFI_Install_Guide/Sandboxing_the_Firefox_Browser_with_Firejail) for further details (the setup described therein *will* work on `arm64`; I use it configured that way on my own RPi3s).
* It is a similar story with the Mozilla Thunderbird mail client. Its `bindist`-compliant developer edition (installed on the image) is named 'Earlybird'.
  * Claws Mail has also been pre-installed on the image, if you want a lighter-weight, but still fully featured, mail client.

* By default, the image uses the Pi's [VC4 GPU](https://wiki.gentoo.org/wiki/Raspberry_Pi_VC4) acceleration in X, which has reasonable support in the 4.14.y kernel and the supplied userspace (via `media-libs/mesa` etc.) Note however that this is still work in progress, so you may experience issues with certain applications. The image uses the mixed-mode [`vc4-fkms-v3d`](https://www.raspberrypi.org/forums/viewtopic.php?f=29&t=159853) overlay / driver (see `/boot/config.txt`). On my RPi3 at least, a `glxgears` score of ~1000fps can be obtained on an unloaded system  (~400fps on a loaded desktop) - in the same ballbark as the non-free Raspbian driver. Incidentally, in normal use the main load is the Xfce window manager's compositor - try turning it off to see (via <kbd>Applications</kbd>&rarr;<kbd>Settings</kbd>&rarr;<kbd>Window Manager Tweaks</kbd>, <kbd>Compositor</kbd> tab) . YMMV - if you experience problems with this setup (or find that e.g. your system is stuck on the 'rainbow square' at boot time after a kernel update), you can fall-back to the standard framebuffer mode by commenting out the `dtoverlay=vc4-fkms-v3d` line in `/boot/config.txt` (i.e., the file `config.txt` located in the microSD card's first partition).
   > Kodi, VLC and SMPlayer have been pre-installed on the image, and they will all make use of accelerated (Mesa/gl) playback. Because of incompatibilities and periodic crashes when using it, XVideo (xv) mode has been disabled in the X server (`/etc/X11/xorg.conf.d/50-disable-Xv.conf`); this doesn't really impinge on usability. NB: **if you find video playback framerates too slow**, it is always worth **disabling the window manager's compositor** (see point immediately above) as a first step. Hint: for some video types, SMPlayer and Kodi perform significantly better than VLC, so if you do experience 'glitchy' playback with one media player, try using one of the others.

* ALSA sound on the system is operative and routed by default through the headphone jack on the Pi. If you connect a sound-capable HDMI monitor (or television) sound should automatically also play through that device (in parallel) - at the moment there is only one 'master' volume control available.
   > In addition to Kodi, VLC and SMPlayer (all of which can play audio) the image also includes Clementine, which has good audio library support and is well integrated with on-line music services. NB - on first launch, Clementine sometimes fails to start, if it has difficulties creating its necessary database files. If this occurs, log out, log back in, and try launching Clementine again. Once it has first started successfully (for a given user) the issue disappears.
   
   > Hint: if you have headphones connected to your RPi3, but can't hear anything, issue (as the regular user, in a terminal) `amixer -c 0 cset numid=3 1` to force sound to route to the onboard jack (this will cause HDMI output to be muted too). Issue `amixer -c 0 cset numid=3 0` to turn HDMI audio output on again.

* If you are using the Pi-Top image, and have one or more pi-topSPEAKER units plugged in, the HDMI audio stream will [automatically play](#ptspeaker) though these. You should also be able to change the [screen backlight brightness](#ptbrightness) using the [keyboard buttons](#ptkeycuts), see the [remaining battery charge](#ptbattery) in the top panel, and find that the when you shut down your system, the hub [powers off](#ptpoweroff) your Pi-Top properly.
  * Pi-Top (v1) users: you can (at your option) swap out your existing RPi3 Model B board for a RPi3 Model B+; everything should work as before, but performance will be increased somewhat (the peak normal clock speed of the B+ is faster (at 1.4GHz) than the B (at 1.2GHz); also, the B+ includes a heat spreader, so is less prone to thermal throttling when worked hard).

* The frequency governor is switched to `ondemand` (from the default, `powersave`), for better performance, as of version 1.0.1. This is managed by the `sys-apps/rpi3-ondemand-cpufreq` package (see [below](#ondemand)).
  * If you are using an RPi3 Model B board, the frequency will switch dynamically between 600MHz and 1.2GHz, depending on load. On a Model B+, it will switch between 600MHz and 1.4GHz.

* `PermitRootLogin yes` has explicitly been set in `/etc/ssh/sshd_config`, and `sshd` is present in the `default` runlevel. This is for initial convenience only - feel free to adopt a more restrictive configuration.
* I haven't properly tested suspend to RAM or suspend to swap functionality yet.
* As of version 1.0.1, all users in the `wheel` group (which includes `demouser`) have a passwordless sudo ability for all commands. Modify `/etc/sudoers` via `visudo` to change this, if desired (the relevant line is `%wheel ALL=(ALL) NOPASSWD: ALL`).
* As mentioned [above](#morespace), by default on first boot the image will attempt to automatically expand the root (second) partition to fill all remaining free space on the microSD card. If, for some reason, you elected _not_ to do this (and so renamed the sentinel file `autoexpand_root_partition` to `autoexpand_root_none` prior to first boot), you can easily expand the size of the second (root) partition manually, so that you have more free space to work in, using the tools (`fdisk` and `resize2fs`). See [these instructions](http://geekpeek.net/resize-filesystem-fdisk-resize2fs/), for example. I **strongly** recommend you do expand the root partition (whether using the default, first-boot mechanism or manually) if you are intending to perform large package (or kernel) builds on your Pi (it isn't necessary just to play around with the image of course).
* <a id="touchscreen"></a>If you are using the [official 7" touchscreen](https://www.element14.com/community/docs/DOC-78156/l/raspberry-pi-7-touchscreen-display) with your RPi3, you can rotate the display (and touch input) 180&deg; (to make it the right way up for the default case orientation) by appending `lcd_rotate=2` to `/boot/config.txt`, and restarting. Also, as of v1.1.3 of the image, the [`twofing`](http://plippo.de/p/twofing) daemon is included and will run automatically on startup; this lets you two-finger press to simulate right click, and also enables a limited repertoire of two-finger gestures (zoom/pinch, rotate, scroll etc.) within some apps. The daemon has no effect when the touchscreen is not connected. The `onboard` on-screen keyboard is also available (again, as of v1.1.3); activate it via <kbd>Applications</kbd>&rarr;<kbd>Accessories</kbd>&rarr;<kbd>Onboard</kbd>.
* As of version 1.2.0 of the image, the SPI interface has been activated (via `/boot/config.txt`); feel free to comment this out again if you need the GPIO lines it uses.
  * Additionally, as of 1.2.0, the necessary binaries for using your RPi3 to [disable the Intel Management Engine](https://wiki.gentoo.org/wiki/Sakaki's_EFI_Install_Guide/Disabling_the_Intel_Management_Engine) are now bundled with the image. Together with the above change, this allows your system to be used to run [`me_cleaner`](https://github.com/corna/me_cleaner) 'out of the box' (provided you have the correct [hardware connector and wires](https://wiki.gentoo.org/wiki/Sakaki's_EFI_Install_Guide/Disabling_the_Intel_Management_Engine#Prerequisites), of course). Users uninterested in this particular application are unaffected, and need take no action.

* The image uses the RPi3's hardware random number generator to feed `/dev/random` (via `sys-apps/rng-tools`); see [these notes](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-boot/rpi3-64bit-firmware) for further details.
* As a (limited, 64-bit) build of `media-libs/raspberrypi-userland` is included, you can use `vcgencmd` etc. Note however that MMAL and OpenMAX IL features are *not* currently supported (this is an issue for *all* 64-bit OS on the RPi3 at present, please see [here](https://forums.gentoo.org/viewtopic-p-8106974.html#8106974) and [here](https://github.com/raspberrypi/userland/issues/460)).
* If you wish to share files on a network with Windows boxes, please note that `net-fs/samba` is bundled as of version 1.2.2 of the image. To configure and activate it, please see e.g. [these notes](https://forums.gentoo.org/viewtopic-p-8215174.html#8215174).
* An `sysctl.d` rule (`35-low-memory-cache-settings.conf`) is used to modify the kernel cache settings slightly, for better performance in a memory constrained environment, per [these notes](https://www.codero.com/knowledge-base/pdf.php?cat=3&id=388&artlang=en).
* As of version 1.2.2 of the image, a startup service (`rpi3-safecompositor`) is used to turn off display compositing if a high pixel clock is detected (> 1.2175MHz, currently). This is because certain applications, for example LibreOffice v6 Draw and Impress, can cause the whole system to lock-up when used with compositing on under such conditions.
* Also as of version 1.2.2, a startup service (`rpi3-ethfix`) is used to workaround certain RPi3B+ Ethernet issues via `ethtool`.
* You can easily install (and run) 32-bit Raspbian apps on your 64-bit Gentoo system if you like (using `apt-get` from a `chroot`), since [ARMv8 supports mixed-mode userland](https://community.arm.com/processors/f/discussions/3330/how-aarch32-bit-applications-will-be-supported-on-aarch64?ReplyFilter=Answers&ReplySortBy=Answers&ReplySortOrder=Descending). If this interests you, please see my wiki entry on this subject, [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Running-32-bit-Raspbian-Packages-on-your-64-bit-Gentoo-System).
* To install source packages with resource-intensive build profiles, you can temporarily mount the image within a `binfmt_misc` QEMU user-mode `chroot` on your PC, and perform the `emerge` there. For further details, please see my wiki tutorial [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Build-aarch64-Packages-on-your-PC%2C-with-User-Mode-QEMU-and-binfmt_misc).
* If you would like to run **benchmarks** on your RPi3 system, please see [these notes](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Effective-Benchmarking-on-your-64-Bit-RPi3-System).
* You can easily remove unwanted applications, and even the Xfce4 graphical desktop itself, from your 64-bit Gentoo system if desired. To do so, please refer to my notes [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Create-a-Slimmed-Down-Version-of-the-Image).
* If you are interested in a Docker variant of the image, please see necrose99's notes [here](https://github.com/necrose99/gentoo-on-rpi3-64bit/tree/master/Dockerstuff).
* As of version 1.3.0 of the image, the weekly-gated rsync mirror URI has changed, to `rsync://isshoni.org/gentoo-portage-pi64-gem`. This mirror has no `porthash`  `repo.hash{,.asc}` files present in it, so may be checked by Portage's official `gemato` verification tool (and this will be done automatically for you during `genup` runs). The `porthash` tool itself (which previous versions of the image used for tree verification) has now been retired.
   > The old `rsync://isshoni.org/gentoo-portage-pi64` (non `-gem`) mirror will continue to be updated also for now, but will likely be withdrawn at some point in the future.

## <a id="maintnotes"></a>Maintenance Notes (Advanced Users Only) (&darr;[skip](#miscpoints))

The following are some notes regarding optional maintenance tasks. The topics here may be of interest to advanced users, but it is not necessary to read these to use the image day-to-day.

### <a id="revertkernelbin"></a>Optional: Switch Back to a 'Pure' `bcmrpi3_defconfig` Kernel

As of version 1.2.2 of the image, the default binary kernel package has changed, to `sys-kernel/bccmrpi3-kernel-bis-bin`, the underlying kernel for which uses a slightly augmented version of the upstream `bcmrpi3-defconfig`, thereby enabling a number of useful additional facilities (such as KVM, ZSWAP etc).

However, if you'd rather use the 'vanilla' `sys-kernel/bccmrpi3-kernel-bin` (i.e., "pure" `bcmrpi3_defconfig`) kernel package, as was the case for <= v1.2.1 of the image, you can do so easily; simply become root, and issue:
```console
pi64 ~ # emerge --ask --verbose --oneshot sys-kernel/bccmrpi3-kernel-bin
```

Once this completes, reboot immediately, and you'll be using the "old default" binary kernel package again (and this choice will be respected during e.g. `genup` system update runs, going forward).

Switching back to the "-bis" binary kernel package, should you subsequently wish to do so, is just as straightforward; simply become root again and issue:
```console
pi64 ~ # emerge --ask --verbose --oneshot sys-kernel/bccmrpi3-kernel-bis-bin
```

Reboot immediately the above command completes.

### <a id="kernelbuild"></a>Optional: Compiling a Kernel from Source

If you'd like to compile a kernel from source on your new system, rather than using the provided binary package, you can do so easily.

Because (at the time of writing) 64-bit support for the RPi3 is fairly 'cutting edge', you'll need to download the source tree directly, rather than using `sys-kernel/raspberrypi-sources`. I recommend using at least version 4.14.y.

> Actually, you _can_ also use `sys-kernel/raspberrypi-sources` if you like, as that has a 4.14.9999 ebuild. However, to keep things straightforward, I have retained the 'direct clone' instructions in what follows.

The tree you need is maintained [here](https://github.com/raspberrypi/linux).

However first, since it generally makes sense to use a 'stable' branch compiler and `binutils` for kernel builds, but the RPi3 image uses the 'testing' (aka `~arm64`) branch for all packages by default, begin by downgrading your `gcc` compiler and `binutils` on the RPi3 to the 'stable' variants (these versions are also available on the binhost, so the following process shouldn't take long). Become root, and issue:
```console
pi64 ~ # echo "sys-devel/gcc -~arm64" >> /etc/portage/package.accept_keywords/gcc
pi64 ~ # echo "sys-devel/binutils -~arm64" >> /etc/portage/package.accept_keywords/binutils
pi64 ~ # emerge --update --oneshot sys-devel/gcc sys-devel/binutils
pi64 ~ # gcc-config --list-profiles
```

Take a note of the index number of the 'stable branch' version of the compiler returned by the last command above (this will probably be `1`), and then ensure the profile is set (substitute it for `1` in the below, if different):
```console
pi64 ~ # gcc-config 1
pi64 ~ # env-update && source /etc/profile
pi64 ~ # emerge --oneshot sys-devel/libtool
```

This process only needs to be done once. It won't affect your ability to build other packages on your RPi3.

> **NB:** if you are running Gentoo on a microSD card, please be sure that you have an expanded root partition (as described [above](#morespace)) on a >=16GB card, before attempting to build a kernel: this process requires more free space than is present on an 8GB card.

Now, suppose you wish to build the most modern version of the 4.14.y kernel (same major/minor version as on the image). Then, begin by pulling down a [shallow clone](http://stackoverflow.com/q/21833870) of the desired version's branch from [GitHub](https://github.com/raspberrypi/linux) (users with sufficient bandwidth and disk space may of course clone the entire tree, and then checkout the desired branch locally, but the following approach is much faster).

Working logged in as your regular user, _not_ root (for security), issue:
```console
user@pi64 ~ $ mkdir -pv kbuild && cd kbuild
user@pi64 kbuild $ rm -rf linux
user@pi64 kbuild $ git clone --depth 1 https://github.com/raspberrypi/linux.git -b rpi-4.14.y
```

This may take some time to complete, depending on the speed of your network connection.

When it has completed, go into the newly created `linux` directory, and set up the baseline `bcmrpi3_defconfig`:
```console
user@pi64 kbuild $ cd linux
user@pi64 linux $ make distclean
user@pi64 linux $ make bcmrpi3_defconfig
```

Next, modify the configuration if you like to suit your needs (this step is optional, as a kernel built with the stock `bcmrpi3_defconfig` will work perfectly well for most users):
```console
user@pi64 linux $ make menuconfig
```
When ready, go ahead and build the kernel, modules, included firmware and dtbs. Issue:
```console
user@pi64 linux $ nice -n 19 make -j4
```
This will a reasonable time to complete. (Incidentally, the build is forced to run at the lowest system priority, to prevent your machine becoming too unresponsive during this process.)

With the kernel built, we need to install it. Assuming your first microSD card partition is mounted as `/boot` (which, given the `/etc/fstab` on the image (visible [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/fstab)), it should be), become root.

Next, remove the provided binary kernel. Edit the file `/etc/portage/package.use/rpi3-64bit-meta` so it reads (the relevant line is the last one):
```bash
# enable/disable any metapackage USE flags you want here, and then
# re-emerge dev-embedded/rpi3-64bit-meta to have the effect taken up
# e.g.:
#
#    dev-embedded/rpi3-64bit-meta -weekly-genup -porthash
#
# (uncommented) to disable the automated weekly genup (package update)
# run, and to disable the requirement for a signature check on the
# isshoni.org rsync mirror
#
# unless you so specify, we accept all existing default metapackage flags:
# at the time of writing, those were (default flag status shown as + or -):
#
#  + boot-fw : pull in the /boot firmware, configs and bootloader
#  + kernel-bin : pull in the binary kernel package
#  - porthash : pull in repo signature checker, for isshoni.org rsync
#  + weekly-genup: pull in cron.weekly script, to run genup automatically
#  + core: pull in core system packages for image (sudo etc.)
#  + xfce: pull in packages for baseline Xfce4 system (requires core)
#  - pitop: pull in Pi-Top support packages (NB most users will NOT want this;
#      the Pi-Top is a DIY laptop kit based around the RPi3) (requires xfce)
#  - apps: pull in baseline desktop apps (libreoffice etc.) (requires xfce)
#
# NB the main point of the core, xfce, pitop and apps USE flags is just to let
# you reduce what is in your @world set (/var/lib/portage/world).
dev-embedded/rpi3-64bit-meta -kernel-bin
```

Then re-emerge the meta package, to delete the binary kernel package itself:
```console
pi64 ~ # emerge -v rpi3-64bit-meta
pi64 ~ # emerge --depclean
```
> Important: do **not** try to restart your system yet - with the binary kernel uninstalled, you **must** install the new kernel (and DTBs and module set) you have just built, or the image will no longer boot. We will do that next.

Next, substituting your regular user's account name (the one you logged into when building the kernel, above) for `user` in the below, issue:
```console
pi64 ~ # cd /home/user/kbuild/linux
pi64 linux # cp -v arch/arm64/boot/Image /boot/kernel8.img
```

Note that by default, the kernel does _not_ require a separate U-Boot loader.

Next, copy over the device tree blobs (at the time of writing `arm64` was still using the `2710` dtb, but this may change to `2837` in future, so for safety, copy both of these, and also the RPi3 B+ variant):
```console
pi64 linux # cp -v arch/arm64/boot/dts/broadcom/bcm{2710,2837}-rpi-3-b.dtb /boot/
pi64 linux # cp -v arch/arm64/boot/dts/broadcom/bcm2710-rpi-3-b-plus.dtb /boot/
```

> Interestingly, even if you have a RPi3 B+, you don't *actually* need the `bcm2710-rpi-3-b-plus.dtb` dtb to boot it - the system's firmware will intelligently patch your standard `bcm2710-rpi-3-b.dtb` file, if that's all it can find. Nevertheless, it is better hygiene to include it.

Lastly, install the modules:
```console
pi64 linux # make modules_install
pi64 linux # sync
```
> We **don't** do a `make firmware_install` here, since that build target [has been dropped](http://lkml.iu.edu/hypermail/linux/kernel/1709.1/04650.html) for >= 4.14.

All done! After you reboot, you'll be using your new kernel.

It is also possible to cross-compile a kernel on your (Gentoo) PC, which is much faster than doing it directly on the RPi3. Please see the instructions [later in this document](#heavylifting).
> Alternatively, if you set up `distcc` with `crossdev` (also covered in the instructions [below](#heavylifting)), you can call `pump make` instead of `make` to automatically offload kernel compilation workload to your PC. However, if you do use `distcc` in this way, be aware that not all kernel files can be successfully built in this manner; a small number (particularly, at the start of the kernel build) may fall back to using local compilation. This is normal, and the vast majority of files _will_ distribute OK.

If you want to switch **back** to the binary kernel package again, simply comment out the line you added at the end of `/etc/portage/package.use/rpi3-64bit-meta`, and issue:
```console
pi64 ~ # emerge -v rpi3-64bit-meta
```
You will receive warnings about file collisions (as the kernel package overwrites your `/boot/kernel8.img` etc.) but it should go through OK. Reboot, and you'll be using your binary kernel again!

> At this point, you may wish to clean up your old, source-built kernel's modules from `/lib/modules/<your-kernel-release-name>`, to save space.

### <a id="heavylifting"></a>Have your Gentoo PC Do the Heavy Lifting!

The RPi3 does not have a particularly fast processor when compared to a modern PC. While this is fine when running the device in day-to-day mode (as a IME-free lightweight desktop replacement, for example), it does pose a bit of an issue when building large packages from source.
> Of course, as the (>= 1.1.0) image now has a weekly-autobuild [binhost](#binhost) provided, this will only really happen if you start setting custom USE flags on packages like `app-office/libreoffice`, or emerging lots of packages not on the [original pre-installed set](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/world-all-packages).

However, there is a solution to this, and it is not as scary as it sounds - leverage the power of your PC (assuming it too is running Gentoo Linux) as a cross-compilation host!

For example, you can cross-compile kernels for your RPi3 on your PC very quickly (around 5-15 minutes from scratch), by using Gentoo's `crossdev` tool. See my full instructions [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Set-Up-Your-Gentoo-PC-for-Cross-Compilation-with-crossdev) and [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Build-an-RPi3-64bit-Kernel-on-your-crossdev-PC) on this project's open [wiki](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki).

Should you setup `crossdev` on your PC in this manner, you can then take things a step further, by leveraging your PC as a `distcc` server (instructions [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Set-Up-Your-crossdev-PC-for-Distributed-Compilation-with-distcc) on the wiki). Then, with just some simple configuration changes on your RPi3 (see [these notes](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Set-Up-Your-RPi3-as-a-distcc-Client)), you can distribute C/C++ compilation (and header preprocessing) to your remote machine, which makes system updates a lot quicker (and the provided tool `genup` will automatically take advantage of this distributed compilation ability, if available).

> Since they share (different revisions of) the same processor, binaries built in this manner can be used on either a RPi3 Model B or B+, without modification.

### <a id="rpi3_headless"></a>Using your RPi3 as a Headless Server

If you want to run a dedicated server program on your RPi3 (for example, a cryptocurrency miner), you won't generally want (or need) the graphical desktop user interface. To disable it, issue (as root):
```console
pi64 ~ # rc-update del xdm default
```

<a id="reclaim_mem"></a>You can also reclaim the memory reserved for the `vc4` graphics driver (this is optional). To do so, issue:
```console
pi64 ~ # nano -w /boot/config.txt
```

and comment out the following line, so it reads:
```bash
#dtoverlay=vc4-fkms-v3d,cma-256
```

Leave the rest of the file as-is. Save, and exit `nano`.

Reboot your system. You will now have a standard terminal login available only, which greatly saves on system resources.

> Should you wish to completely remove the graphical desktop's _packages_ from your system too, please see my notes [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Create-a-Slimmed-Down-Version-of-the-Image).

Next, ensure that your system won't autoupdate (since this can cause high system load at an unpredictable moment). Log in as root, then issue:
```console
pi64 ~ # echo "dev-embedded/rpi3-64bit-meta -weekly-genup" > /etc/portage/package.use/rpi3-64bit-meta
pi64 ~ # emerge -v rpi3-64bit-meta
```

You can now arrange for your server program to start on boot, either by creating an explicit OpenRC service file in `/etc/init.d/` or by adding an (executable) startup script, named `/etc/local.d/<servicename>.start`, in which you fork off the server using `start-stop-daemon` (or similar).

> I recommend that you run your service at the *lowest* possible system priority (i.e., highest positive number niceness), particularly if it is CPU intensive. This will ensure that you're able to log in successfully using `ssh`, even if the daemon is in a tight CPU-bound loop.

It is generally more reliable to use the Ethernet rather than the WiFi network interface when running a headless server in this manner. Also, make sure your system has an adequate heatsink fitted (or even active CPU cooling, for particularly demanding applications), since the RPi3 (particuarly when running in 64-bit mode) can [get quite hot](https://www.theregister.co.uk/2017/10/18/active_cooling_a_raspberry_pi_3/), leading to thermal throttling or even protective system shutdown if your cooling is insufficient. The RPi3 Model B+ has a [integral heat-spreader](https://core-electronics.com.au/tutorials/raspberry-pi-3-model-b-plus-performance-vs-3-model-b.html), so (in addition to having a higher clock speed) it may be a somewhat better choice than the RPi3 Model B for more demanding applications.

> Of course, take the normal precautions when running an internet-exposed server in this manner: for example, set up an appropriate firewall, consider running the server process under `firejail`, modify the shipped-default passwords, and keep your system up-to-date by (manually) running `genup`, from time to time.

Should you wish to revert back to using the graphical desktop at some point in the future, simply issue (as root):
```console
pi64 ~ # rc-update add xdm default
```

Then, if you edited `/boot/config.txt` [above](#reclaim_mem), undo that change now. Issue:
```console
pi64 ~ # nano -w /boot/config.txt
```

and uncomment the following line, so it reads:
```bash
dtoverlay=vc4-fkms-v3d,cma-256
```

Leave the rest of the file as-is. Save, and exit `nano`. Reboot your system, and you should have your full graphical desktop back again!


## <a id="miscpoints"></a>Miscellaneous Points (Advanced Users Only) (&darr;[skip](#helpwanted))

The following are some notes about the detailed structure of the image. It is not necessary to read these to use the image day-to-day.

### RPi3-Specific Ebuilds

As of version 1.1.0 of the image, all the required firmware and startup files have now been placed under ebuild control, for ease of maintenance going forward:
* <a id="metapackage"></a>A metapackage, [`sys-firmware/rpi3-64bit-meta`](https://github.com/sakaki-/rpi3-overlay/tree/master/dev-embedded/rpi3-64bit-meta) from the (subscribed) [`rpi3`](https://github.com/sakaki-/rpi3-overlay) ebuild repository (overlay) governs the inclusion of all the components discussed below (controlled by a set of USE flags). The version of the metapackage matches the version of the live-USB release to which it pertains.

  > For avoidance of doubt, by default the `rpi3-64bit-meta` metapackage does _not_ specify the various end-user applications installed on the image (such as `libreoffice`, `firefox` etc.), so these may be freely uninstalled or modified as required (if you only intend to install *additional* applications however, you can specify the `apps` USE flag for `rpi3-64bit-meta`, and then remove `libreoffice`, `firefox` etc from your @world set (`/var/lib/portage/world`).
* <a id="boot_fw"></a>The `/boot` firmware (_excluding_ the kernel and DTBs; _those_ are provided by `sys-kernel/bcmrpi3-kernel<-bis>-bin`, discussed later) is provided by [`sys-boot/rpi3-64bit-firmware`](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-boot/rpi3-64bit-firmware): the upstream [`raspberrypi/firmware/boot`](https://github.com/raspberrypi/firmware/tree/master/boot) repo is checked once per week for new release tags, and a new corresponding ebuild created automatically if one is found. This package also pulls in (via [`sys-boot/rpi3-boot-config`](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-boot/rpi3-boot-config)) 'starter' configuration files `/boot/cmdline.txt` and `/boot/config.txt` (with settings matching those on the image), but these are `CONFIG_PROTECT`ed, so any changes you make subsequently will be preserved.
* <a id="wifi"></a>The configuration file `brcmfmac43430-sdio.txt`, required for the RPi3's integrated WiFi, is provided by [`sys-firmware/brcm43430-firmware`](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-firmware/brcm43430-firmware) (its main firmware being provided by the standard [`linux-firmware`](http://packages.gentoo.org/package/sys-kernel/linux-firmware) package).
   * This package now also provides the equivalent file `brcmfmac43455-sdio.txt`, for use with the RPi3 B+'s new [dual-band WiFi](https://www.raspberrypi.com.tw/tag/bcm2837/) setup (Cypress CYW43455), plus the `brcmfmac43430-sdio.clm_blob`.
   * The WiFi regulatory domain (initially set to `GB` on the image), is set by the `rpi3-wifi-regdom` service (provided by the [`net-wireless/rpi3-wifi-regdom`](https://github.com/sakaki-/rpi3-overlay/tree/master/net-wireless/rpi3-wifi-regdom) package); its value may be set by editing the file `/etc/conf.d/rpi3-wifi-regdom`.
* <a id="bluetooth"></a>Firmware (`/etc/firmware/BCM43430A1.hcd`) for the RPi3's integrated Bluetooth transceiver is provided by [`sys-firmware/bcm4340a1-firmware`](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-firmware/bcm4340a1-firmware) (adapted from the Arch Linux [`pi-bluetooth`](https://aur.archlinux.org/packages/pi-bluetooth/) package). A startup service and `udev` rule are provided by the companion [`net-wireless/rpi3-bluetooth`](https://github.com/sakaki-/rpi3-overlay/tree/master/net-wireless/rpi3-bluetooth) package (adapted from the same Arch Linux upstream).
* <a id="ondemand"></a>The `/etc/local.d/ondemand_freq_scaling.start` boot script, which switches the RPi3 from its (`bcmrpi3_defconfig`) default `powersave` CPU frequency governor, to `ondemand`, for better performance, has been switched to a `sysinit` OpenRC service, provided by [`sys-apps/rpi3-ondemand-cpufreq`](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-apps/rpi3-ondemand-cpufreq). On the RPi3 B, this allows the frequency to range up to 1.2GHz, and on the RPi3 B+, up to 1.4GHz, without overclocking.
* <a id="init_scripts"></a>The `autoexpand_root_partition.start` script has been migrated into an OpenRC boot service, provided by [`sys-apps/rpi3-init-scripts`](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-apps/rpi3-init-scripts).
* <a id="expand-swap"></a>On first boot, after the root has been expanded, the default swapfile (at `/var/cache/swap/swap1`) will be auto-expanded to 1,024MiB if possible, by [`sys-apps/rpi3-expand-swap`](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-apps/rpi3-expand-swap); configuration settings in [`/etc/conf.d/rpi3-expand-swap`](https://github.com/sakaki-/rpi3-overlay/blob/master/sys-apps/rpi3-expand-swap/files/conf.d_rpi3-expand-swap-1).
* <a id="zswap"></a>The `zswap` transparent compressing swap cache is set up by [`sys-apps/rpi3-zswap`](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-apps/rpi3-zswap); configuration settings in [`/etc/conf.d/rpi3-zswap`](https://github.com/sakaki-/rpi3-overlay/blob/master/sys-apps/rpi3-zswap/files/conf.d_rpi3-zswap-1).


### <a id="expedited_updates"></a>New Features to Expedite Regular System Updating

In addition to the above, as of version 1.1.0 of the image, a number of other changes have been made to expedite the process of keeping your 64-bit Gentoo RPi3 up-to-date:
* <a id="binary_kp"></a>An autobuild of the official [`raspberrypi/linux`](https://github.com/raspberrypi/linux) kernel (default branch) using `bcmrpi3_defconfig` has been set up [here](https://github.com/sakaki-/bcmrpi3-kernel); a new release tarball is automatically pushed once per week, and a matching kernel binary package ([`sys-kernel/bcmrpi3-kernel-bin`](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-kernel/bcmrpi3-kernel-bin)) is also created simultaneously. A variant of this with a slightly tweaked config is also maintained [here](https://github.com/sakaki-/bcmrpi3-kernel-bis) with binary kernel package ([`sys-kernel/bcmrpi3-kernel-bis-bin`](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-kernel/bcmrpi3-kernel-bis-bin)); this latter version is used by default as of v1.2.2 of the image.

  NB: at the time of writing, the `rpi-4.14.y` branch was the default (receiving most attention for backports etc.) Using `-bin` packages for the kernel makes it easy to switch between them (and to update your kernel, and module set, to the latest version available - along with all other packages on your system - whenever you issue `genup`); you can see the kernels available by issuing `eix bcmrpi3-kernel-bis-bin`. Also, note that by default (via the `with-matching-boot-fw` USE flag) installing a particular `sys-kernel/bcmrpi3-kernel<-bis>-bin` version will _also_ cause the version of `sys-boot/rpi3-64bit-firmware` (see [above](#boot_fw)) current at the time the kernel was released, to be installed (to `/boot`). This helps to reduce issues with firmware / kernel mismatches with cutting edge features such as VC4 support.

  > Use of the provided binary kernel package is optional, you can always uninstall it (by editing the file `/etc/portage/package.use/rpi3-64bit-meta`, setting the `-kernel-bin` USE flag, then issuing `emerge -v rpi3-64bit-meta`) and [building your own kernel](#kernelbuild) instead, if desired.

* <a id="binhost"></a>The project's [Gentoo binhost](https://wiki.gentoo.org/wiki/Binary_package_guide) at https://isshoni.org/pi64pie has been reconfigured to perform a **weekly update and autobuild of all installed (userspace) packages on the image**, allowing your RPi3 to perform fast updates via the resulting binary packages where possible, only falling back to local source-based compilation when necessary (using this facility [is optional](#disable_weekly_update), of course, just like the binary kernel package). <a id="rsync"></a>The binhost also provides a (weekly-gated) `rsync` mirror (`rsync://isshoni.org/gentoo-portage-pi64-gem`) for the main `gentoo` repo (fully compatible with Gentoo's official `gemato` signed hash verification), used to keep your RPi3's "visible" ebuild tree in lockstep with the binary package versions available on the [isshoni.org](https://isshoni.org/pi64pie) binhost (incidentally, the `gentoo` repo on [isshoni.org](https://isshoni.org/pi64pie) itself is maintained against upstream using `webrsync-gpg`).
  > NB: I can make **no guarantees** about the future availability of the weekly autobuilds on [isshoni.org](https://isshoni.org/pi64pie), nor the autoupdated binary kernel packages (on GitHub). However, we use these as part of our own production infrastructure, so they should be around for a while. Use the provided binary packages at your own risk.

* <a id="profile"></a>A custom Gentoo profile, `rpi3:default/linux/arm64/17.0/desktop/rpi3`, is provided (and selected as the active profile on the image), which supplies many of the default build settings, USE flags etc., required for 64-bit Gentoo on the RPi3, again, keeping them in lockstep with the binhost (and ensuring you will have a binary package available when upgrading any of the pre-installed software packages on the image). You can view this profile (provided via the [rpi3](https://github.com/sakaki-/rpi3-overlay) ebuild repository) [here](https://github.com/sakaki-/rpi3-overlay/tree/master/profiles/targets/rpi3).
  > NB: as of release 1.2.0, the profile has changed, from `rpi3:default/linux/arm64/13.0/desktop/rpi3` to `rpi3:default/linux/arm64/17.0/desktop/rpi3`, reflecting the underlying [Gentoo profile upgrade](https://www.gentoo.org/support/news-items/2017-11-30-new-17-profiles.html) from 13.0 to 17.0. Users of prior releases interested in manually upgrading should read [these notes](https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases#upgrade_to_profile_17).

<a id="why_weekly_update"></a>These features, viz.:
* the `rpi3:default/linux/arm64/17.0/desktop/rpi3` [profile](https://github.com/sakaki-/rpi3-overlay/tree/master/profiles/targets/rpi3),
* the weekly autobuild [isshoni.org binhost](https://isshoni.org/pi64pie),
* the 'weekly-gated', signature-authenticated portage rsync mirror (`rsync://isshoni.org/gentoo-portage-pi64-gem`), and
* the [`sys-kernel/bcmrpi3-kernel-bis-bin`](https://github.com/sakaki-/rpi3-overlay/tree/master/sys-kernel/bcmrpi3-kernel-bis-bin) binary kernel package)

make **updating a typical system (with few user-added packages) possible with a near 100% hit rate on the binhost's binaries**. As such, updating (via [`genup`](https://github.com/sakaki-/genup), for example, or an old-school `eix-sync && emerge -uDUav --with-bdeps=y @world`) is _much_ less onerous than before, and so has been **automated** on the image (via the `app-portage/weekly-genup` package, which installs a script in `/etc/cron.weekly`). This automated weekly updating can easily be disabled if you do not wish to use it (simply edit the file `/etc/portage/package.use/rpi3-64bit-meta` and set the `-weekly-genup` USE flag, then `emerge -v rpi3-64bit-meta`).

### Subscribed Ebuild Repositories (_aka_ Overlays)

The image is subscribed to the following ebuild repositories:
* **gentoo**: this is the main Gentoo tree of course, but is (by default) supplied via `rsync://isshoni.org/gentoo-portage-pi64-gem`, a weekly-gated, signature-authenticated portage rsync mirror locked to the binhost's available files, as described [above](#rsync).
* **[sakaki-tools](https://github.com/sakaki-/sakaki-tools)**: this provides a number of small utilities for Gentoo. The image currently uses the following ebuilds from the `sakaki-tools` overlay:
  * **app-portage/showem** [source](https://github.com/sakaki-/showem), [manpage](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/showem.pdf)

    A tool to view the progress of parallel `emerge` operations.
  * **app-portage/genup** [source](https://github.com/sakaki-/genup), [manpage](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/genup.pdf)

    A utility for keeping Gentoo systems up to date.
  * **app-portage/porthash** [source](https://github.com/sakaki-/porthash), [manpage](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/porthash.pdf)

    Checks, or creates, signed 'master' hashes of Gentoo repos (useful when distributing via e.g. `rsync`). Retired as of version 1.3.0 of this image in favour of Gentoo's official `gemato` verification.
  * **sys-apps/me_cleaner** [upstream](https://github.com/corna/me_cleaner)

    A tool for partial deblobbing of Intel ME/TXE firmware images, used to disable the Intel Management Engine (ME). Now bundled with the image for convenience, for those who would like to use their RPi3 as an external programmer to reflash the firmware on their PC. See [these notes](https://wiki.gentoo.org/wiki/Sakaki's_EFI_Install_Guide/Disabling_the_Intel_Management_Engine) for further details.
  * **sys-apps/coreboot-utils** [upstream](https://www.coreboot.org)

    Provides some tools useful for inspection of Intel firmware images (used with `me_cleaner`, above).
  * **app-portage/porthole** [upstream](http://porthole.sourceforge.net)

    A GTK+-based front end to Portage. At the time of writing, required slight patching to work, hence this overlay. Will revert to using the default repo at the next revbump.
  * **media-gfx/fotoxx** [upstream](https://www.kornelix.net/fotoxx/fotoxx.html)

    A program for improving image files from digital cameras (HDR etc). Supplies v18.01.3, which is not yet in the Gentoo tree.
* **[rpi3](https://github.com/sakaki-/rpi3-overlay)**: this provides ebuilds specific to the Raspberry Pi 3, or builds that have fallen off the main Gentoo tree but which are the last known reliable variants for `arm64`. It also provides the [custom profile](#profile) [`rpi3:default/linux/arm64/17.0/desktop/rpi3`](https://github.com/sakaki-/rpi3-overlay/tree/master/profiles/targets/rpi3). The image currently uses the following ebuilds from the `rpi3` overlay:

  * **dev-embedded/rpi3-64bit-meta**
   This is the main `gentoo-on-rpi3-64bit` metapackage - its version matches that of the image release (currently, 1.3.0). The features it pulls in (via other ebuilds) can be customized via the following USE flags (edit via `/etc/portage/package.use/rpi3-64bit-meta`):<a name="meta_use_flags"></a>
   
     | USE flag | Default? | Effect |
     | -------- | --------:| ------:|
     | `boot-fw` | Yes | Pull in the /boot firmware, configs and bootloader. |
     | `kernel-bin` | Yes | Pull in the `bcmrpi3-kernel<-bis>-bin` binary kernel package. |
     | `porthash` | No | Pull in repo signature checker, for isshoni.org `rsync`. |
     |  `weekly-genup` | Yes | Pull in `cron.weekly` script, to run `genup` automatically. |
     |  `core` | Yes | Pull in core system packages for image (`sudo` etc.). |
     |  `xfce` | Yes | Pull in packages for baseline Xfce4 system. Requires `core`. |
     |  `pitop` | No | Pull in Pi-Top packages (NB most users **won't** want this). Requires `xfce`. |
     |  `apps` | No | Pull in baseline desktop apps (`libreoffice` etc). Requires `xfce`. |


  * **sys-firmware/brcm43430-firmware** [upstream](https://github.com/RPi-Distro/firmware-nonfree)
    Just provides a configuration file (`brcmfmac43430-sdio.txt`) that is required for the RPi3's integrated WiFi (the main firmware is provided already, by [`sys-kernel/linux-firmware`](http://packages.gentoo.org/package/sys-kernel/linux-firmware)). Now also provides the equivalent file `brcmfmac43455-sdio.txt`, for use with the RPi3 B+'s [dual-band WiFi](https://www.raspberrypi.com.tw/tag/bcm2837/) WiFi chip set (Cypress CYW43455), plus the matching `brcmfmac43430-sdio.clm_blob`.
  * **net-wireless/rpi3-wifi-regdom**
    Provides a simple service to set the WiFi regulatory domain; the value set may be modified by editing the file `/etc/conf.d/rpi3-wifi-regdom`.
  * **sys-firmware/bcm4340a1-firmware** [upstream](https://aur.archlinux.org/packages/pi-bluetooth/)
    Provides firmware (`/etc/firmware/BCM43430A1.hcd`) for the RPi3's integrated Bluetooth transceiver. Adapted from the [`pi-bluetooth`](https://aur.archlinux.org/packages/pi-bluetooth/) package from ArchLinux. Required by `net-wireless/rpi3-bluetooth` package (see below).
  * **net-wireless/rpi3-bluetooth** [upstream](https://aur.archlinux.org/packages/pi-bluetooth/)
    Provides a startup service and `udev` rule for the RPi3's integrated Bluetooth transceiver. Adapted from the [`pi-bluetooth`](https://aur.archlinux.org/packages/pi-bluetooth/) package from ArchLinux.
  * **sys-devel/portage-distccmon-gui**
    Desktop file (and wrapper) to view Portage jobs with `distccmon-gui` (provided your user is a member of the `portage` group). Currently installed on the image, but _not_ controlled by the `rpi3-64bit-meta` metapackage.
  * **sys-kernel/bcmrpi3-kernel-bin**
    Provides ebuilds to install the available binary packages for the 64-bit `bcmrpi3_defconfig` Linux kernels (for the Raspberry Pi 3 model B and B+), which are updated weekly [here](https://github.com/sakaki-/bcmrpi3-kernel).
  * **sys-kernel/bcmrpi3-kernel-bis-bin**
    Provides ebuilds to install the available binary packages for the 64-bit `bcmrpi3_defconfig` Linux kernels (for the Raspberry Pi 3 model B and B+), which are updated weekly [here](https://github.com/sakaki-/bcmrpi3-kernel-bis). This version is used by default in preference to `bcmrpi3-kernel-bin` as of v1.2.2 of the image, as it includes some additional kernel configuration items such as KVM (but either is acceptable).
  * **media-libs/raspberrypi-userland**
    Provides a (restricted) 64-bit build (`-DARM64=ON`) of `raspberrypi-userland`, for`vcgencmd` etc. The ebuild needs tidying, so please use with care ><
  * **sys-apps/rpi3-init-scripts**
    Provides a few simple init scripts (to autoexpand the root partition on first boot, etc.).
  * **app-portage/weekly-genup**
    Installs a simple cron.weekly script, to automate `genup`, and another, to run 'fixups' (small scripts to correct issues that may e.g. prevent correct `genup` operation etc.).
  * **sys-apps/rpi3-ondemand-cpufreq**
    Provides the `rpi3-ondemand` OpenRC `sysinit` service, which switches the RPi3 from its (`bcmrpi3_defconfig`) default `powersave` CPU frequency governor, to `ondemand`, for better performance.
  * **x11-misc/rpi3-safecursor**
    Provides the `rpi3-safecursor` OpenRC service, which will install a rule to force software cursor blitting (rather than the hardware default) if the user has not set `disable_overscan=1` in `config.txt`. Introduced to deal with issue #17. The service no-ops with the supplied 4.14.y kernel however, as this has a fix [already committed](https://github.com/raspberrypi/linux/commit/81bbe80e7bebab6211c72bf0c0f81a4bc2370eab).
  * **app-portage/rpi3-check-porthash**
    Provides a [`porthash`](https://github.com/sakaki-/porthash) signed hash check for the [isshoni.org](https://isshoni.org) rsync gentoo ebuild repository, implemented as a `repo.postsync.d` hook. NB not installed as of v1.3.0 of the image, as Gentoo's official `gemato` signature check is used instead; please see the release notes [here](https://github.com/sakaki-/gentoo-on-rpi3-64bit/releases/tag/v1.3.0).
  * **sys-boot/rpi3-64bit-firmware** [upstream](https://github.com/raspberrypi/firmware)
    Provides the firmware and config files required in `/boot` to boot the RPi3 in 64-bit mode. Does not provide the kernel or DTBs (see `sys-kernel/bcmrpi3-kernel<-bis>-bin`, above, for that). A weekly check is made to see if a new tag has been added to the official [`raspberrypi/firmware/boot`](https://github.com/raspberrypi/firmware/tree/master/boot) upstream, and, if so, a matching ebuild is automatically created here.
  * **dev-embedded/wiringpi** [upstream](http://wiringpi.com/)
    Provides Gordon Henderson's `WiringPi`, a PIN based GPIO access library (with accompanying `gpio` utility).
  * **xfce-extra/xfce4-fixups-rpi3**
    Effects some useful new-user fixups for Xfce4 on the RPi3 (forcing compositing to sync to the vertical blank etc.). Installs an `/etc/xdg/autostart/xfce4-fixups-rpi3.desktop` entry.
  * <a id="ptkeycuts"></a>**xfce-extra/xfce4-keycuts-pitop**
    Installs some simple keyboard shortcuts for the Pi-Top (an RPi3-based DIY laptop). Only installed on the Pi-Top variant image.
  * <a id="ptbattery"></a>**xfce-extra/xfce4-battery-plugin** [upstream](https://github.com/rricharz/pi-top-battery-status)
    A modified version of the standard `xfce4-battery-plugin` gas gauge. It is patched with code from [rricharz](https://github.com/rricharz/pi-top-battery-status) to query the status of the Pi-Top's battery over I2C; this code is activated by building with the `pitop` USE flag. Only installed on the Pi-Top variant image.
  * <a id="ptpoweroff"></a>**sys-apps/pitop-poweroff**
    Provides a simple OpenRC shutdown service, to ensure that the Pi-Top's onboard hub controller is properly powered off. Only installed on the Pi-Top variant image.
  * **sys-apps/rpi3-spidev**
    Provides a `udev` rule for SPI access on the RPi3; ensures that the `/dev/spidevN.M` devices are read/write for all members of the `wheel` group, not just `root`. Only installed by default on the Pi-Top variant image (but usable on any RPi3).
  * **sys-apps/rpi3-i2cdev**
    Proves an OpenRC service and `udev` rule for I2C access on the RPi3. Ensures that the `i2c-dev` module is `modprobe`d, and that the `/dev/i2c-[0-9]` devices are read/write for all members of the `wheel` group, not just `root`. Only installed by default on the Pi-Top variant image (but usable on any RPi3).
  * <a id="ptbrightness"></a>**dev-embedded/pitop-utils** [upstream](https://github.com/rricharz/pi-top-install)
    Provides the `pt-poweroff` and `pt-brightness` `sbin` utilities for the Pi-Top. Only installed on the Pi-Top variant image.
  * <a id="ptspeaker"></a>**dev-embedded/pitop-speaker** [upstream](https://github.com/pi-top/pi-topSPEAKER)
    Provides the `ptspeaker` Python 3 package and accompanying OpenRC service, to initialize pitopSPEAKER add-on-boards. The init has been adapted from the original Debian package and does _not_ use `pt-peripherals-daemon`. Only installed on the Pi-Top variant image
  * **x11-misc/twofing** [upstream](http://plippo.de/p/twofing)
    Provides the `twofing` daemon, which converts touchscreen gestures into mouse and keyboard events. Included primarily for use with the official 7" RPi (1,2,3) touchscreen.
  * **app-accessibility/onboard** [upstream](https://launchpad.net/onboard)
    Provides a flexible onscreen keyboard. Again, included primarily for use with the official 7" RPi (1,2,3) touchscreen. Adapted with thanks from original ebuild, [here](https://bitbucket.org/wjn/wjn-overlay).
  * **media-tv/kodi** [upstream](https://github.com/xbmc/xbmc)
    Provides `kodi-17.4_rc1.ebuild`; adapted from the version in the main Gentoo tree (with `~arm64` keyworded, and the dependency list modified to avoid relying on MS fonts with a non-free licence (the remaining deps and the package itself being FOSS licensed)).
  * **xfce-extra/xfc4-mixer** [upstream](http://softwarebakery.com/maato/volumeicon.html)
    Provides `xfc4-mixer-4.99.0-r1`, a 'pseudo-package' replacing the original, treecleaned `xfce4-mixer` with the (broadly equivalent) `media-sound/volumeicon` package.
  * **sys-apps/qdiskusage** [upstream](http://www.qt-apps.org/content/show.php/QDiskUsage?content=107012)
    Provides `qdiskusage-1.99.0.ebuild`, a dummy, as this has now been removed from the main Gentoo tree, and the local copy no longer builds, due to missing deps.
  * **x11-themes/gnome-icon-theme** [upstream](https://www.gnome.org)
    Provides `gnome-icon-theme-3.12.0-r1.ebuild`; this has been removed from the main Gentoo tree, but is still required for some icons on the image.
  * **xfce-extra/xfce4-notifyd** [upstream](https://goodies.xfce.org/projects/applications/xfce4-notifyd)
    Provides `xfce4-notifyd-0.4.0.ebuild`; this has been removed from the main Gentoo tree, but is still used on the image. Upgrades masked because of message truncation, which causes problems with PIN notification during Bluetooth device setup. To be fixed / resolved soon.
  * **xfce-extra/xfce4-indicator-plugin** [upstream](https://goodies.xfce.org/projects/panel-plugins/xfce4-indicator-plugin)
    Provides `xfce4-indicator-plugin-2.3.3-r2.ebuild`; this has been removed from the main Gentoo tree, and the v2.3.4 is currently masked.
  * **net-misc/ethfix**
    Effects some simple Ethernet workarounds (using `ethtool`) for the RPi3B+.
  * **sys-apps/rpi3-expand-swap**
    Expands the default swapfile (`/var/cache/swap/swap1`) to 1,024MiB on first boot (after the root filesystem has been expanded), subject to sufficient space.
  * **sys-apps/rpi3-zswap**
    Activates the `zswap` kernel facility to transparently compress, and cache in RAM, pages that are being evicted to swap. Can significantly improve responsiveness of the RPi3 when a number of large applications are open. Configured via `/etc/conf.d/rpi3-zswap`.
  * **www-client/firefox** [upstream](http://www.mozilla.com/firefox)
    Provides `firefox-61.0-r1.ebuild`; this has been removed from the main Gentoo tree, but is in use on the image until v62 or later builds, at which point it will be unmasked and `firefox` should revert to the using main-tree ebuild.
  * **sys-boot/rpi3-boot-config**
    Provides the 'starter' configuration files `/boot/cmdline.txt` and `/boot/config.txt`.
  * **net-wireless/blueman**
    Provides `blueman-2.0.4-r1.ebuild`; this has been removed from the main Gentoo tree, but is in use on the image (until the current version proves stable, at which point it will be unmasked, and `blueman` will revert to using the main-tree ebuild).
  * **x11-misc/rpi3-safecompositor**
    Provides an OpenRC service to off display compositing if a high pixel clock is detected (> 1.2175MHz, currently). This is because certain applications, for example LibreOffice v6 Draw and Impress, can cause the whole system to lock-up when used with compositing on under such conditions.
  * **net-misc/ethfix**
    Provides an OpenRC service to workaround certain RPi3B+ Ethernet issues via `ethtool`.
  * **app-office/orage** [upstream](https://git.xfce.org/apps/orage/)
    Provides `orage-4.12.1-r1.ebuild`, patched for [bug 657542](https://bugs.gentoo.org/657542). Once this revbumps in the main Gentoo tree, `orage` should revert to using that version instead.
  
## <a id="helpwanted"></a>Help Wanted!

You've got this far through the README - I'm impressed ^-^. In fact, you may be just the sort of person to help get `arm64` into a more stable state in the main Gentoo tree...

To that end, if you have managed to get additional packages (not included in the original [pre-installed set](https://github.com/sakaki-/gentoo-on-rpi3-64bit/blob/master/reference/world-all-packages)) working reliably on your `gentoo-on-rpi3-64bit` system, please feel free to submit PRs for the relevant [profile](#profile) elements of the [`rpi3` overlay](https://github.com/sakaki-/rpi3-overlay/tree/master/profiles/targets/rpi3) (for example, `package.accept_keywords`, `package.bashrc` and `package.use` entries). Not only will upstreaming your changes help other users in the short term, it will also create a shared knowledge base (about how to get various packages working on `arm64`) that can be used as a sourcebook for keywording PRs (etc.) to the main Gentoo tree.

Within reason, I'm also happy to consider adding working packages to the set maintained by the weekly-autobuild [binhost](#binhost); just open an [issue](https://github.com/sakaki-/gentoo-on-rpi3-64bit/issues) to request this.

## Acknowledgement

I'd like to acknowledge NeddySeagoon's work getting Gentoo to run in 64-bit mode on the RPi3 (see particularly [this thread](https://forums.gentoo.org/viewtopic-t-1041352.html), which was a really useful reference when putting this project together).

## Feedback Welcome!

If you have any problems, questions or comments regarding this project, feel free to drop me a line! (sakaki@deciban.com)

