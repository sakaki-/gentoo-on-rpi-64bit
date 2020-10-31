# gentoo-on-rpi-64bit
Bootable 64-bit Gentoo image for the Raspberry Pi 4 Model B, and Pi 3 B and B+, with Linux 5.4, OpenRC, Xfce4, VC4/V3D, camera & h/w codec support, profile 17.0, weekly-autobuild binhost

> 30 Oct 2020: sadly, due to legal obligations arising from a recent change in my 'real world' job, I must announce I am **standing down as maintainer of this project with immediate effect**. For the meantime, I will leave the repo up (for historical interest, and since the images may be of use still in certain applications); however, there will be no further updates to the underlying binhost etc., nor will I be accepting / actioning further pull requests or bug reports from this point. Email requests for support will also have to be politely declined, so, **please treat this as an effective EOL notice**.<br><br>For further details, please see my post [here](https://www.raspberrypi.org/forums/viewtopic.php?p=1750206#p1750206).<br><br>Gentoo *itself* on the aarch64 / 64-bit RPi platform remains very much a going concern of course; please see e.g. [this forum](https://forums.gentoo.org/viewforum-f-62.html) for more details.<br><br>With sincere apologies, sakaki ><

## Description

<img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi4/Raspberry_Pi_3_B_and_B_plus_and_4_B.jpg" alt="[Raspberry Pi 4B, 3B and B+]" width="250px" align="right"/>

This project is a bootable, microSD card **64-bit Gentoo image for the [Raspberry Pi 4 model B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/), 
[3 model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/) and [3 model B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)** single board computers (SBC).

The image's userland contains a complete (OpenRC-based) Gentoo system (including a full Portage tree) - so you can run `emerge` operations immediately - and has been pre-populated with a reasonable package set (Xfce v4.14, LibreOffice v6.4.4.2, Firefox Quantum v77.0.1, Chromium v84.0.4147.30, Thunderbird v68.9.0, VLC v3.0.10-r1, Kodi v18.7.1, GIMP v2.10.18-r1 etc.) so that you can get productive *without* having to compile anything first! Unless you *want* to, of course; this being Gentoo, GCC v10.1.0, Clang v10.0.0, IcedTea v3.16.0 (OpenJDK 8), Go v1.14.4, Rust v1.44.0 and various versions of Python are of course bundled also ^-^ As of version 1.2.0 of the image, all userland software has been built under Gentoo's 17.0 profile, and, as of version 1.5.0 of the image, **the new RPi4 Model B is also supported** (and to reflect this, the project itself has been renamed, from `gentoo-on-rpi3-64bit` to `gentoo-on-rpi-64bit` ^-^).

The kernel and userland are both 64-bit (`arm64`/`aarch64`), and support for the Pi's [VC4](https://wiki.gentoo.org/wiki/Raspberry_Pi_VC4) GPU (VC6 on the Pi4) has been included (using [`vc4-fkms-v3d`](https://www.raspberrypi.org/forums/viewtopic.php?f=29&t=159853) / Mesa), so rendering performance is reasonable (e.g., `glxgears` between 400 and 1200fps, depending on load and system type; real-time video playback). The Pi's onboard Ethernet, WiFi (dual-band on the RPi3 B+ / Pi4 B) and Bluetooth adaptors are supported, as is the official 7" [touchscreen](#touchscreen) (if you have one). Sound works too, both via HDMI (given an appropriate display), and the onboard headphone jack. As of version 1.1.0 of the image, a [weekly-autobuild binhost](#binhost), custom [Gentoo profile](#profile), and [binary kernel package](#binary_kp) have been provided, making it relatively painless to keep your system up-to-date (and, because of this, [`genup`](https://github.com/sakaki-/genup) has been configured to run [automatically once per week](#weekly_update), by default). As of version 1.4.0 of the image, access to the RPi3's hardware video codecs (and camera module, if you have one) [is supported](#v4l2) too, via the V4L2 framework, and, as of version 1.5.0, these features are available on the RPi4 also. Additionally, on the RPi4, the use of dual monitors is supported (but not required) as of version 1.5.0 (as is accelerated graphics, via V3D / Mesa). And, there is no 3GiB 'memory ceiling' anymore: if you are fortunate enough to own a 8GiB Pi4, all 8GiB of that RAM is usable. As of 1.5.2, [64-bit MMAL userland](#mmal) is supported (and used by bundled tools like `raspivid`), as is automated update of the RPi4's onboard EEPROM firmware. And finally, as of 1.6.0, `rpi-5.4.y` kernels are supported, the FOSS Jitsi videoconferencing server is bundled, and `elogind` is used in place of `consolekit`.

Here's a screenshot of the image running on a dual-display RPi4 B (click to show a higher resolution view):

<a href="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi4/demo-screenshot-1.6.0-pi4-ds-white-bg-v2.jpg"><img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi4/demo-screenshot-1.6.0-pi4-ds-white-bg-small-v2.jpg" alt="[gentoo-on-rpi-64bit in use on Pi4 (screenshot)]" width="960px"/></a>

The image may be downloaded from the link below (or via `wget`, per the instructions which follow).

<a id="downloadlinks"></a>Variant | Version | Image | Digital Signature
:--- | ---: | ---: | ---:
Raspberry Pi  4B, 3B/B+ 64-bit Full | v1.6.0 | [genpi64.img.xz](https://github.com/sakaki-/gentoo-on-rpi-64bit/releases/download/v1.6.0/genpi64.img.xz) | [genpi64.img.xz.asc](https://github.com/sakaki-/gentoo-on-rpi-64bit/releases/download/v1.6.0/genpi64.img.xz.asc)
Raspberry Pi 4B, 3B/B+ 64-bit Lite | v1.6.0 | [genpi64lite.img.xz](https://github.com/sakaki-/gentoo-on-rpi-64bit/releases/download/v1.6.0/genpi64lite.img.xz) | [genpi64lite.img.xz.asc](https://github.com/sakaki-/gentoo-on-rpi-64bit/releases/download/v1.6.0/genpi64lite.img.xz.asc)

**NB:** most users will want the first, full image ([genpi64.img.xz](https://github.com/sakaki-/gentoo-on-rpi-64bit/releases/download/v1.6.0/genpi64.img.xz)) - the 'lite' variant ([genpi64lite.img.xz](https://github.com/sakaki-/gentoo-on-rpi-64bit/releases/download/v1.6.0/genpi64lite.img.xz)) boots to a command-line (rather than a graphical desktop), and is intended only for experienced Gentoo users (who wish to to *e.g.* set up a server).

> The previous release versions are still available (together with a detailed changelog) [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/releases). If you have a significant amount of work invested in an older release of this image, I have also provided manual upgrade instructions (from 1.0.0 thru 1.5.4 &rarr; 1.6.0) [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/releases#upgrade_to_1_6_0).

Please read the instructions below before proceeding. Also please note that all images (and binary packages) are provided 'as is' and without warranty. You should also be comfortable with the (at the moment, unavoidable) non-free licenses required by the firmware and boot software supplied on the image before proceeding: these may be reviewed [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/tree/master/licenses).

> It is sensible to install Gentoo to a **separate** microSD card from that used by your default Raspbian system; that way, when you are finished using Gentoo, you can simply power off, swap back to your old card, reboot, and your original system will be just as it was.

> Please also note that support for `arm64` is still in its [early stages](https://wiki.gentoo.org/wiki/Raspberry_Pi) with Gentoo, so it is quite possible that you may encounter strange bugs etc. when running a 64-bit image such as this one. A lot of packages [have been `* ~*` keyworded](https://github.com/sakaki-/genpi64-overlay/tree/master/profiles/targets/rpi3/package.accept_keywords) to get the system provided here to build... but hey, if you like Gentoo, little things like that aren't likely to put you off ^-^

## Table of Contents

- [Prerequisites](#prerequisites)
- [Downloading and Writing the Image](#downloading-and-writing-the-image)
  * [Full Image (genpi64.img.xz)](#regularimage)
  * [Lite Image (genpi64lite.img.xz)](#liteimage)
- [Booting!](#booting)
- [Using Gentoo](#using-gentoo)
- [Keeping Your System Up-To-Date](#keeping-your-system-up-to-date)
  * [Installing New Packages Under Gentoo](#installing-new-packages-under-gentoo)
- [Miscellaneous Configuration Notes, Hints, and Tips](#miscellaneous-configuration-notes-hints-and-tips-skip)
- [Maintenance Notes (Advanced Users Only)](#maintenance-notes-advanced-users-only-skip)
  * [Optional: Switch Back to a 'Pure' bcmrpi3_defconfig / bcm2711_defconfig Kernel](#revertkernelbin)
  * [Optional: Compiling a Kernel from Source](#kernelbuild)
  * [Have your Gentoo PC Do the Heavy Lifting!](#have-your-gentoo-pc-do-the-heavy-lifting)
  * [Using your RPi3 as a Headless Server](#rpi3_headless)
- [Miscellaneous Points (Advanced Users Only)](#miscellaneous-points-advanced-users-only-skip)
  * [RPi-Specific Ebuilds](#rpi-specific-ebuilds)
  * [New Features to Expedite Regular System Updating](#new-features-to-expedite-regular-system-updating)
  * [Subscribed Ebuild Repositories (aka Overlays)](#subscribed-ebuild-repositories-aka-overlays)
- [Project Wiki](#projectwiki)
- [Help Wanted!](#help-wanted)
- [Acknowledgement](#acknowledgement)
- [Feedback Welcome!](#feedback-welcome)

## Prerequisites

To try this out, you will need:
* For the **full** image (which most users will want), a [microSD](https://en.wikipedia.org/wiki/Secure_Digital) card of _at least_ 16GB capacity (as this image is 1,961MiB compressed, 12.25GiB == 13.15GB uncompressed, so it should fit on any card marked as >= 16GB). For the **'lite'** image, a card marked as >= 8GB should suffice (as this image is 755MiB compressed, 7.25GiB == 7.78GB uncompressed). If you intend to build many additional large packages (or kernels) on your RPi, a card of >16GB is recommended (the root partition will [automatically be expanded](#morespace) to fill the available space on your microSD card, on first boot). Depending on the slots available on your PC, you may also need an adaptor to allow the microSD card to be plugged in (to write the image to it initially). [Class A1 cards](https://www.raspberrypi.org/forums/viewtopic.php?p=1517864#p1517864) are particularly recommended, but not required.
   > I have found most SanDisk cards work fine; if you are having trouble, a good sanity check is to try writing the [standard Raspbian 32-bit image](https://www.raspberrypi.org/downloads/raspbian/) to your card, to verify that your Pi4 (or Pi3) will boot with it, before proceeding.

* A Raspberry Pi 4 Model B, or Pi 3 Model B or B+ (obviously!).
For simplicity, I am going to assume that you will be logging into the image (at least initially) via an (HDMI) screen and (USB) keyboard connected directly to your Pi, rather than e.g. via `ssh` (although, for completeness, it *is* possible to `ssh` in via the Ethernet interface (which has a DHCP client running), if you can determine the allocated IP address, for example from your router, or via [`nmap`](https://security.stackexchange.com/a/36200)).
A [decent power supply](https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=138636) is recommended.

* A PC to decompress the image and write it to the microSD card. This is most easily done on a Linux machine of some sort, but it is straightforward on a Windows or Mac box too (for example, by using [Etcher](https://etcher.io), which is a nice, all-in-one cross-platform graphical tool for exactly this purpose - it's free and open-source; or, bzt's [usbimager](https://gitlab.com/bztsrc/usbimager), a very lightweight cross-platform open source image writer). In the instructions below I'm going to assume you're using Linux.
   > It is possible to use your Raspberry Pi for this task too, if you have an external card reader attached, or if you have your root on e.g. USB (and take care to unmount your existing /boot directory before removing the original microSD card), or are booted directly from USB. Most users will find it simplest to write the image on a PC, however.

## Downloading and Writing the Image

Choose either the full (recommended for most users) or 'lite' (command-line only) variant, then follow the appropriate instructions below ([full](#regularimage) or [lite](#liteimage)).

> If you are using a Windows or Mac box, or prefer to use a GUI tool in Linux, I recommend you download your preferred image via your web browser using the [links](#downloadlinks) above, and then check out either of the the free, open-source, cross-platform tools [Etcher](https://etcher.io) or [usbimager](https://gitlab.com/bztsrc/usbimager) to write it to microSD card. Then, once you've done that, continue reading at ["Booting!"](#booting) below.

> Alternatively, for those who prefer the Raspberry Pi [NOOBS](https://www.raspberrypi.org/documentation/installation/noobs.md) installer GUI, both images are now available for installation using [PINN](https://github.com/procount/pinn) (called `gentoo64` and `gentoo64lite` there). PINN is a fork of NOOBS and includes a number of additional advanced features. Please see [this post](https://forums.gentoo.org/viewtopic-p-8122236.html#8122236) for further details. *Many thanks to [procount](https://github.com/procount) for his work on this.*

### <a id="regularimage"></a>Full Image (`genpi64.img.xz`)

On your Linux box, issue (you may need to be `root`, or use `sudo`, for the following, hence the '#' prompt):
```console
# wget -c https://github.com/sakaki-/gentoo-on-rpi-64bit/releases/download/v1.6.0/genpi64.img.xz
# wget -c https://github.com/sakaki-/gentoo-on-rpi-64bit/releases/download/v1.6.0/genpi64.img.xz.asc
```

<img src="https://github.com/sakaki-/resources/raw/master/raspberrypi/pi4/rpi4-desktop.png" alt="RPi4 Running Full Image" height="200px" align="right"/>

to fetch the compressed disk image file (~1,961MiB) and its signature.

Next, if you like, verify the image using gpg (this step is optional):
```console
# gpg --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-key DDE76CEA
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

The above `xzcat` to the microSD card will take some time, due to the decompression (it takes between 5 and 25 minutes on my machine, depending on the microSD card used). It should exit cleanly when done - if you get a message saying 'No space left on device', then your card is too small for the image, and you should try again with a larger capacity one.
> <a id="morespace"></a>Note that on first boot, the image will _automatically_ attempt to resize its root partition (which, in this image, includes `/home`) to fill all remaining free space on the microSD card, by running [this startup service](https://github.com/sakaki-/genpi64-overlay/blob/master/sys-apps/rpi3-init-scripts/files/init.d_autoexpand_root-4); if you _do not_ want this to happen (for example, because you wish to add extra partitions to the microSD card later yourself), then simply **rename** the (empty) sentinel file `autoexpand_root_partition` (in the top level directory of the `vfat` filesystem on the first partition of the microSD card) to `autoexpand_root_none`, before attempting to boot the image for the first time.

Now continue reading at ["Booting!"](#booting) below.

### <a id="liteimage"></a>Lite Image (`genpi64lite.img.xz`)

> Please note: this image boots to a command line, not a GUI, and is only suitable for experienced Gentoo users. If unsure, choose the [full image](#regularimage) above, instead.

On your Linux box, issue (you may need to be `root`, or use `sudo`, for the following, hence the '#' prompt):
```console
# wget -c https://github.com/sakaki-/gentoo-on-rpi-64bit/releases/download/v1.6.0/genpi64lite.img.xz
# wget -c https://github.com/sakaki-/gentoo-on-rpi-64bit/releases/download/v1.6.0/genpi64lite.img.xz.asc
```

<img src="https://github.com/sakaki-/resources/raw/master/raspberrypi/pi4/rpi4-console.png" alt="[RPi4 Running Lite Image]" height="200px" align="right"/>

to fetch the compressed disk image file (~755MiB) and its signature.

Next, if you like, verify the image using gpg (this step is optional):
```console
# gpg --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-key DDE76CEA
# gpg --verify genpi64lite.img.xz.asc genpi64lite.img.xz
```

Assuming that reports 'Good signature', you can proceed. (Warnings that the key is "not certified with a trusted signature" are normal and [may be ignored](http://security.stackexchange.com/questions/6841/ways-to-sign-gpg-public-key-so-it-is-trusted).)

Next, insert (into your Linux box) the microSD card on which you want to install the image, and determine its device path (this will be something like `/dev/sdb`, `/dev/sdc` etc. (if you have a [USB microSD card reader](http://linux-sunxi.org/Bootable_SD_card#Introduction)), or perhaps something like `/dev/mmcblk0` (if you have e.g. a PCI-based reader); in any case, the actual path will depend on your system - you can use the `lsblk` tool to help you). Unmount any existing partitions of the card that may have automounted (using `umount`). Then issue:

> **Warning** - this will *destroy* all existing data on the target drive, so please double-check that you have the path correct! As mentioned, it is wise to use a spare microSD card as your target, keeping your existing Raspbian microSD card in a safe place; that way, you can easily reboot back into your existing Raspbian system, simply by swapping back to your old card.

```console
# xzcat genpi64lite.img.xz > /dev/sdX && sync
```

Substitute the actual microSD card device path, for example `/dev/sdc`, for `/dev/sdX` in the above command. Make sure to reference the device, **not** a partition within it (so e.g., `/dev/sdc` and not `/dev/sdc1`; `/dev/sdd` and not `/dev/sdd1` etc.)
> If, on your system, the microSD card showed up with a path of form `/dev/mmcblk0` instead, then use this as the target, in place of `/dev/sdX`. For this naming format, the trailing digit *is* part of the drive name (partitions are labelled as e.g. `/dev/mmcblk0p1`, `/dev/mmcblk0p2` etc.). So, for example, you might need to use `xzcat genpi64lite.img.xz > /dev/mmcblk0 && sync`.

The above `xzcat` to the microSD card will take some time, due to the decompression (it takes between 5 and 10 minutes on my machine, depending on the microSD card used). It should exit cleanly when done - if you get a message saying 'No space left on device', then your card is too small for the image, and you should try again with a larger capacity one.
> Note that on first boot, the image will _automatically_ attempt to resize its root partition (which, in this image, includes `/home`) to fill all remaining free space on the microSD card, by running [this startup service](https://github.com/sakaki-/genpi64-overlay/blob/master/sys-apps/rpi3-init-scripts/files/init.d_autoexpand_root-4); if you _do not_ want this to happen (for example, because you wish to add extra partitions to the microSD card later yourself), then simply **rename** the (empty) sentinel file `autoexpand_root_partition` (in the top level directory of the `vfat` filesystem on the first partition of the microSD card) to `autoexpand_root_none`, before attempting to boot the image for the first time.

Now continue reading at ["Booting!"](#booting), immediately below. Note, however, that in the case of this 'lite' image, after the startup / resize process has completed, you will be landed at a console login prompt (although it is simple enough to [parlay to a basic X11 desktop](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Setup-a-Simple-X11-Desktop-Environment-on-the-Lite-Image) if you wish). The login credentials are the same as for the full image, *viz.*:
* default user **demouser**, password **raspberrypi64**;
* **root** user password also **raspberrypi64**.

> Hint: you can use the bundled tool `nmtui` to easily establish a WiFi network connection from the command line.

> Hint: if you wish to use your RPi3/4 in a *headless* context, as of v1.5.2 of the image you can edit the file `startup.sh` on the first partition, to e.g. set up fixed network IP addresses, specify WiFi login passphrases etc. The file can be edited on any PC (since the first partition is formatted FAT) and you need to make any changes prior to first boot. The shipped `startup.sh` contains a [number of (commented) examples](https://github.com/sakaki-/genpi64-overlay/blob/master/sys-apps/rpi-onetime-startup/files/startup.sh-2) to help get you oriented. Users booting the image on a system with attached mouse, keyboard and monitor can ignore this facility of course, since networking can be configured via the GUI, once booted.


## <a id="booting"></a>Booting!

Begin with your RPi4 (or RPi3) powered off. Remove the current (Raspbian or other) microSD card from the board (if fitted), and store it somewhere safe.

Next, insert the (Gentoo) microSD card you just wrote the image to into the Pi. Ensure you have peripherals connected (with the main display plugged into the **HDMI0** port - the one nearer the USB-C power connector - if using an RPi4), and apply power.

You should see the Pi's standard 'rainbow square' on-screen for about 2 seconds, then the display will go blank for about 10 seconds, and then (once the graphics driver has loaded) a text console will appear, showing OpenRC starting up. On this first boot (unless you have renamed the sentinel file `autoexpand_root_partition` in the microSD card's first partition to `autoexpand_root_none`), the system will, after a further 10 seconds or so, _automatically resize_ the root partition to fill all remaining free space on the drive, and, having done this, reboot (to [allow the kernel to see](http://unix.stackexchange.com/questions/196435/is-it-possible-to-enlarge-the-partition-without-rebooting) the new partition table). You should then see the 'rainbow square' startup sequence once more, and then the system will resize its root filesystem, to fill the newly enlarged partition. Once this is done, it will launch a standard Xfce desktop, logged in automatically to the pre-created `demouser` account. A simple configuration application will also be autostarted; this allows you to e.g. change screen resolution, if required:

<img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi4/xfce-desktop-small.png" alt="[Baseline Xfce desktop]" width="960px"/>

> If your display looks OK, there's no need to make any changes immediately - just click <kbd>OK</kbd> to dismiss the welcome dialog, and then click on the <kbd>Cancel</kbd> button to close out the configuration tool itself.

The whole process (from first power on to graphical desktop) should take less than three minutes or so (on subsequent reboots, the resizing process will not run, so startup will be a _lot_ faster).

> The initial **root** password on the image is **raspberrypi64**. The password for **demouser** is also **raspberrypi64** (you may need this if e.g. the screen lock comes on; you can also do `sudo su --login root` to get a root prompt at the terminal, without requiring a password). These passwords are set by the [`autoexpand-root`](https://github.com/sakaki-/genpi64-overlay/blob/master/sys-apps/rpi3-init-scripts/files/init.d_autoexpand_root-4) startup service. Note that the screensaver for `demouser` has been disabled by default on the image.

> NB - if your connected computer monitor or TV output appears **flickering or distorted**, you may need to change the settings in the file `config.txt`, located in the microSD card's first partition (this partition is formatted `vfat` so you should be able to edit it on any PC; alternatively, when booted into the image, it is available at `/boot/config.txt`). Any changes made take effect on the next restart. For an explanation of the various options available in `config.txt`, please see [these notes](https://www.raspberrypi.org/documentation/configuration/config-txt/README.md) (the [shipped defaults](https://github.com/sakaki-/genpi64-overlay/blob/master/sys-boot/rpi3-boot-config/files/config.txt-9) should work fine for most users, however). As of v1.3.1 of this image, you can also use the bundled GUI tool (shown in the screenshot above) to modify (some of) these settings. The program, `pyconfig_gen`, is, as noted, automatically started on first login, and is available under <kbd>Applications</kbd>&rarr;<kbd>Settings</kbd>&rarr;<kbd>RPi Config Tool</kbd>.

> If the edges of the desktop appear "clipped" by your display (this mostly happens when using HDMI TVs), issue `sudo mousepad /boot/config.txt`, comment out the line `disable_overscan=1` (so it reads instead `#disable_overscan=1`), save the file, and then reboot (from v1.3.1, you can also enable and configure overscan via the <kbd>Rpi Config Tool</kbd>, as noted above). Please note that with modern boot firmware, [overscan is ignored](https://github.com/raspberrypi/linux/issues/3059#issuecomment-510108535) if a DMT mode is set.

> Tip: if you'd like to set up a persistent dual-monitor setup on an RPi4, please see my short tutorial on this project's open wiki [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Set-Up-Dual-Displays-on-your-RPi4) (this also contains useful hints for setting up a single display).

## <a id="using_gentoo"></a>Using Gentoo

The supplied image contains a fully-configured `~arm64` Gentoo system (*not* simply a [minimal install](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Media#Minimal_installation_CD) or [stage 3](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Media#What_are_stages_then.3F)), with a complete Portage tree already downloaded, so you can immediately perform `emerge` operations etc. Be aware that, as shipped, it uses **UK locale settings, keyboard mapping, timezone and WiFi regulatory domain**; however, these are easily changed if desired. See the Gentoo Handbook ([here](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Base#Timezone) and [here](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/System#Init_and_boot_configuration)) for details on the first three; to customize the WiFi regulatory domain, start the <kbd>Applications</kbd>&rarr;<kbd>Settings</kbd>&rarr;<kbd>RPi Config Tool</kbd> app, select the <kbd>WiFi</kbd> tab, choose your location from the drop-down, click <kbd>Save and Exit</kbd>, and reboot when prompted.

> Please note that for non-UK keyboards, **prior** to v1.5.4 of the image, you will also need to edit the file `/etc/X11/xorg.conf.d/00-keyboard.conf` and replace  `gb` in the line `Option "XkbLayout" "gb"` with the appropriate code from [this list](https://pastebin.com/v2vCPHjs). Leave the rest of the file as-is, save, then reboot for the change to take effect. You will need to be the `root` user, or use `sudo` to edit this file (e.g., type `sudo mousepad /etc/X11/xorg.conf.d/00-keyboard.conf` in a terminal). **From** v1.5.4 however, a simpler GUI-driven method is available. Simply click <kbd>Applications</kbd>&rarr;<kbd>Settings</kbd>&rarr;<kbd>Keyboard</kbd>, select the <kbd>Layout</kbd> tab, ensure <kbd>Use system defaults</kbd> is _unchecked_, and then, in the <kbd>Keyboard layout</kbd> section, click on <kbd>Add</kbd> to insert the layouts you need to use. For example, the image has `English (UK)` and `English (US)` selected, but you should obviously choose whatever works for you. Do not add more than four layouts (or the switcher plugin will not work correctly). You can use the arrow keys to re-order the list (if you have more than one layout); the one at the _top_ will be the default activated at login time. Once done, click on <kbd>Close</kbd> to dismiss the dialog. You should now find that you can switch layouts (if you have specified more than one) either by clicking on the top panel-bar keyboard plugin (the one next to the `Demo User` text on the far right) or by pressing the hotkey (by default, this is <kbd>Windows Key</kbd><kbd>Space</kbd>).

If you have an RPi4, and would like to configure a **dual monitor** setup, please see [these notes](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Set-Up-Dual-Displays-on-your-RPi4) (also contains some useful hints for single monitor deployment, applicable to all models).

If you wish to add Bluetooth peripherals (e.g., a wireless mouse and/or keyboard) to your RPi, please see [below](#add_bt_device).

If you would like to run **benchmarks** on your RPi system, please see [these notes](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Effective-Benchmarking-on-your-64-Bit-RPi-System).

For hardware-accelerated YouTube playback, please see [this post](https://www.raspberrypi.org/forums/viewtopic.php?p=1589280#p1589280). Also please note that as of v1.5.4 of the image, you can (particularly on a Pi4B with a fast Internet connection) use <kbd>Applications</kbd>&rarr;<kbd>Internet</kbd>&rarr;<kbd>SMTube (YouTube, Hi-Res)</kbd> to play back videos from YouTube in 1080p, where available; this is significantly better than the currently bundled browsers (Firefox and Chromium) can achieve.

The `@world` set of packages (from `/var/lib/portage/world`) pre-installed on the image may be viewed [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/blob/master/reference/world-packages) (note that the version numbers shown in this list are Gentoo ebuilds, but they generally map 1-to-1 onto upstream package versions).
> The *full* package list for the image (which includes @system and dependencies) may also be viewed, [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/blob/master/reference/world-all-packages).

The system on the image has been built via a minimal install system and stage 3 from Gentoo (`arm64`, available [here](http://distfiles.gentoo.org/experimental/arm64/)), but _all_ binaries (libraries and executables) have been rebuilt (with profile 17.0) to run optimally on the Raspberry Pi 4 B's Cortex-A72-based SoC, while still retaining backwards compatibility with the older Pi 3 (B and B) model's Cortex-A53. The `/etc/portage/make.conf` file used on the image may be viewed [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/blob/master/reference/make.conf), augmented by the [custom profile's](#profile) [`make.defaults`](https://github.com/sakaki-/genpi64-overlay/tree/master/profiles/targets/rpi3/make.defaults). The `CHOST` on the image is `aarch64-unknown-linux-gnu` (per [these notes](https://wiki.gentoo.org/wiki/User:NeddySeagoon/Pi3#Getting_Started)). All packages have been brought up to date against the Gentoo tree as of 11 June 2020. The image contains *two* kernels: one ([`bcmrpi3-kernel-bis`](https://github.com/sakaki-/bcmrpi3-kernel-bis)) is used when booting on the RPi3 B/B+, and the other ([`bcm2711-kernel-bis`](https://github.com/sakaki-/bcm2711-kernel-bis)) when booting on an RPi4. The correct kernel is chosen automatically at boot time. Each kernel has a distinct release name, and so a separate module set in `/lib/modules/`.

> Note: the `CFLAGS` used for the image build is `-march=armv8-a+crc -mtune=cortex-a72 -O2 -pipe`. You can of course re-build selective components with more aggressive flags yourself, should you choose. As the SIMD FPU features are standard in ARMv8, there is no need for `-mfpu=neon mfloat-abi=hard` etc., as you would have had on e.g. the 32-bit ARMv7a architecture. Note that AArch64 NEON also has a full IEEE 754-compliant mode (including handling denormalized numbers etc.), there is also no need for `-ffast-math` flag to fully exploit the FPU either (again, unlike earlier ARM systems). Please refer to the official [Programmer’s Guide for ARMv8-A](http://infocenter.arm.com/help/topic/com.arm.doc.den0024a/DEN0024A_v8_architecture_PG.pdf) for more details. Neither the Pi3 nor Pi4 is shipped with the ARMv8 hardware crypto extensions enabled, unfortunately.

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

<a id="add_new_account"></a>If you want to create your own account, you can do so easily. Open a terminal, su to root, then issue (adapting with your own details, obviously!):
```console
pi64 ~ # useradd --create-home --groups "adm,disk,lp,wheel,audio,video,cdrom,usb,users,plugdev,portage,cron,gpio,i2c,spi" --shell /bin/bash --comment "Sakaki" sakaki
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

One hint worth bearing in mind: desktop compositing is on for new users by default (unless you are using a Pi3 and have a very high-resolution display, when it will automatically be turned off for you). This gives nicely rendered window shadows etc. but if you find video playback framerates (from `VLC` etc.) are too slow, try turning it off (<kbd>Applications</kbd>&rarr;<kbd>Settings</kbd>&rarr;<kbd>Window Manager Tweaks</kbd>, <kbd>Compositor</kbd> tab).

> Note that as of version 1.1.2 of the image, a number of Xfce 'fixups' will automatically be applied when a new user logs in for the first time; these include:<br>1) synchronizing compositing to the vertical blank (without which menus flash annoyingly under VC4);<br>2) setting window move and resize opacity levels; and<br>3) ensuring the desktop background displays on login (otherwise it often stays black; note that this fix sometimes does not work for the *first* login of a new user, as noted [above](black_background_first_login)).<br>They are managed by the `xfce-extra/xfce4-fixups-rpi3` package (which inserts an entry into `/etc/xdg/autostart/`).

## <a id="weekly_update"></a>Keeping Your System Up-To-Date

You can update your system at any time. As there are quite a few steps involved to do this correctly on Gentoo, I have provided a convenience script, `genup` ([source](https://github.com/sakaki-/genup), [manpage](https://github.com/sakaki-/gentoo-on-rpi-64bit/blob/master/reference/genup.pdf)) to do this as part of the image.

Note that **by [default](#why_weekly_update), this script will run automatically once per week, commencing the second week after first boot** (see the task installed in `/etc/cron.weekly`). Review the logfile `/var/log/latest-genup-run.log` to see changes made by the latest auto-update run.

> As of version 1.3.0 of the image, a number of additional 'fixups' will also be applied weekly - these are small scripts (which may be viewed [here](https://github.com/sakaki-/genpi64-overlay/tree/master/app-portage/weekly-genup/files)) used to address emergent issues that e.g. may prevent your system updating correctly. The output may be reviewed in `/var/log/latest-fixup-run.log`. Disabling auto-updating (see text immediately below) will also disable the fixup cronjob.

<a id="disable_weekly_update"></a>If you would rather _not_ use auto-updating, simply edit the file `/etc/portage/package.use/rpi-64bit-meta` so it reads (the relevant line is the last one):
```bash
# Enable/disable any metapackage USE flags you want here, and then
# re-emerge dev-embedded/rpi-64bit-meta to have the effect taken up
# e.g. you might set (uncommented):
#
#    dev-embedded/rpi-64bit-meta -weekly-genup
#
# to disable the automated weekly genup (package update)
# run.
#
# Unless you override them, the default metapackage flags are used.
# At the time of writing, those are (default flag status shown as + or -):
#
#  + boot-fw : pull in the /boot firmware, configs and bootloader
#  + kernel-bin : pull in the binary kernel package
#  - porthash : pull in repo signature checker, for isshoni.org rsync
#  + weekly-genup: pull in cron.weekly script, to run genup automatically
#  + innercore: pull in essential system packages for image (RPi initscripts etc.)
#  + core: pull in main packages for image (clang etc.) (requires innercore)
#  + xfce: pull in packages for baseline Xfce4 system (requires core)
#  - pitop: pull in Pi-Top support packages (NB most users will NOT want this;
#      the Pi-Top is a DIY laptop kit based around the RPi3) (requires xfce)
#  - apps: pull in baseline desktop apps (libreoffice etc.) (requires xfce)
#
# NB the main point of the core, xfce, pitop and apps USE flags is just to let
# you reduce what is in your @world set (/var/lib/portage/world).
dev-embedded/rpi-64bit-meta -weekly-genup
```

Then re-emerge the meta package, which will remove the `cron` entry (NB: doing it this way ensures the entry *stays* removed, even if you later manually update your system):
```console
pi64 ~ # emerge -v rpi-64bit-meta
```

Of course, you can always use `genup` directly (as root) to update your system at any time. See the [manpage](https://github.com/sakaki-/gentoo-on-rpi-64bit/blob/master/reference/genup.pdf) for full details of the process followed, and the options available for the command.

> Bear in mind that a `genup` run will take around three to six hours to complete, even if all the necessary packages are available as binaries on the [binhost](#binhost). Why? Well, since Gentoo's [Portage](https://wiki.gentoo.org/wiki/Portage) - unlike most package managers - gives you the flexibility to specify which package versions and configuration (via USE flags) you want, it has a nasty graph-theoretic problem to solve each time you ask to upgrade (and it is mostly written in Python too, which doesn't help ^-^). Also, many of the binary packages are themselves quite large (for example, the current `libreoffice` binary package is >100MiB) and so time-consuming to download (unless you have a very fast Internet connection).

When an update run has completed, if prompted to do so by genup (directly, or at the tail of the `/var/log/latest-genup-run.log` logfile), then issue:
```console
pi64 ~ # dispatch-conf
```
to deal with any config file clashes that may have been introduced by the upgrade process.

For more information about Gentoo's package management, see [my notes here](https://wiki.gentoo.org/wiki/Sakaki's_EFI_Install_Guide/Installing_the_Gentoo_Stage_3_Files#Gentoo.2C_Portage.2C_Ebuilds_and_emerge_.28Background_Reading.29).

> You may also find it useful to keep an eye on this project's (sticky) thread in the 'Gentoo on ARM' forum at [gentoo.org](https://forums.gentoo.org/viewtopic-t-1098232.html), as I occasionally post information about this project there.

### Installing New Packages Under Gentoo

> The following is only a *very* brief intro to get you started. For more information, see the [Gentoo handbook](https://wiki.gentoo.org/wiki/Handbook:AMD64/Working/Portage).

You can add any additional packages you like to your RPi. To search for available packages, you can use the (pre-installed) [`eix` tool](https://wiki.gentoo.org/Eix). For example, to search for all packages with 'hex editor' in their description:

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

> Note that if you intend to install complex packages, you may find it easier to set `ACCEPT_KEYWORDS="* ~*"` in `/etc/portage/make.conf`, since many packages are not yet keyworded for `arm64` yet on Gentoo. Obviously, this will throw up some false positives, but it will also mostly prevent Portage from suggesting you pull in 'live' (aka `-9999`, aka current-tip-of-source-control) ebuilds, which can easily create a nasty dependency tangle.

Once you get a package working successfully, you can then explicitly keyword its dependencies if you like (in `/etc/portage/package.accept_keywords/...`), rather than relying on `ACCEPT_KEYWORDS="* ~*"` in `/etc/portage/make.conf`. Should you do so, please feel free to file a PR against the [`genpi64:default/linux/arm64/17.0/desktop/genpi64` profile](https://github.com/sakaki-/genpi64-overlay/tree/master/profiles/targets/rpi3) with your changes, so that others can benefit (I intend to submit keywords from this profile to be considered for inclusion in the main Gentoo tree, in due course).

Have fun! ^-^

> If you need to install a particular package that isn't currently in the Gentoo tree, note that it _is_ possible to install binary packages from Raspbian (or other 32-bit repos) on your 64-bit system. For further details, please see [these notes](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Running-32-bit-Raspbian-Packages-on-your-64-bit-Gentoo-System).

> Alternatively, to install source packages with highly resource-intensive build profiles (such as `dev-lang/rust`), you can temporarily mount the image within a `binfmt_misc` QEMU user-mode `chroot` on your Linux PC, and perform the `emerge` there. This technique allows you to easily leverage the increased memory and CPU throughput of your regular desktop machine. For further details, please see my wiki tutorial [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Build-aarch64-Packages-on-your-PC%2C-with-User-Mode-QEMU-and-binfmt_misc).

## Miscellaneous Configuration Notes, Hints, and Tips (&darr;[skip](#maintnotes))

You don't need to read the following notes to use the image, but they may help you better understand what is going on!

> NB some of the following notes need updating for the new 1.6.0 image. I plan to do this shortly.

* For simplicity, the image uses a single `ext4` root partition (includes `/home`), which [by default](#morespace) will be auto-resized to fill all remaining free space on the microSD card on first boot. Also, to allow large packages (such as `gcc`) to be built from source without running out of memory on smaller systems, a 1 GiB swapfile has been set up at `/var/cache/swap/swap1`, and on boot this will be auto-resized if necessary, if space becomes tight (by [this service](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-apps/rpi3-expand-swap)). Feel free to modify this configuration as desired (for example, you can significantly improve performance under load by setting up a dedicated swap device on a separate bus from the system's rootfs; for details, please see [this short tutorial](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Improve-Swap-Perfomance-on-your-RPi)).
   > Incidentally, it *is* possible to get an RPi3 Model B to boot from a USB drive (no microSD card required); see for example [these instructions](http://www.makeuseof.com/tag/make-raspberry-pi-3-boot-usb/) (try at your own risk!), and furthermore the RPi3 Model B+ can boot a USB-written image *without* modification, as it has the necessary OTP fuses factory set. Alternatively, you can retain `/boot` on the microSD card, but use a USB drive for the system root (remember to modify `/boot/cmdline.txt` and `/etc/fstab` accordingly, if you choose to go this route). At the time of writing, the RPi4 does not yet support direct USB boot (although this feature is pending, and you can always use the split sys{b,r}oot method just mentioned: NB, *if* doing so I recommend you use the a USB2 port for your rootfs on the RPi4, until the [FIQ](https://www.raspberrypi.org/forums/viewtopic.php?p=1510558#p1510558) is implemented on the aarch64 kernel).

* As of version 1.3.0 of the image, the [`zswap`](https://en.wikipedia.org/wiki/Zswap) in-memory transparent compressing swap cache is in use. Under most normal workloads, this should improve responsiveness when the system starts to run out of memory, by intercepting swapped-out memory pages, compressing them, and storing them in a dynamic RAM buffer instead of hitting flash. The `rpi3-zswap` service may be viewed [here](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-apps/rpi3-zswap), and configured via `/etc/conf.d/rpi3-zswap`. 

* Because the Pi has no battery-backed real time clock (RTC), I have used the `swclock` (rather than the more usual `hwclock`) OpenRC boot service on the image - this simply sets the clock on boot to the recorded last shutdown time. An NTP client, `chronyd`, is also configured, and this will set the correct time as soon as a valid network connection is established.
   > Note that this may cause a large jump in the time when it syncs, which in turn will make the screensaver lock come on. Not a major problem, but something to be aware of, as it can be quite odd to boot up, log in, and have your screen almost immediately lock! For this reason, the `demouser` account on the image has the screensaver disabled by default.

* The image is configured with `NetworkManager`, so achieving network connectivity should be straightforward. The Ethernet interface is initially configured as a DHCP client, but obviously you can modify this as needed. Use the NetworkManager applet (top right of your screen) to do this; you can also use this tool to connect to a WiFi network.
   > Note that getting WiFi to work on the RPi3/4 requires appropriate firmware (installed in `/lib/firmware/brcm`): this is managed by the `sys-firmware/brcm43430-firmware` package (see [below](#wifi)). On the RPi3 B+ and RPi4 B, dual-band WiFi is supported.

* Bluetooth *is* operational on this image, but since, by default, the Raspberry Pi 3 [uses the hardware UART](http://www.briandorey.com/post/Raspberry-Pi-3-UART-Overlay-Workaround) / `ttyAMA0` to communicate with the Bluetooth adaptor, the standard serial console does not work and has been disabled (see `/etc/inittab` and `/boot/cmdline.txt`). You can of course [change this behaviour](https://www.raspberrypi.org/forums/viewtopic.php?t=138120) if access to the hardware serial port is important to you.
   > Bluetooth on the RPi3/4 also requires a custom firmware upload. This is carried out by a the `rpi3-bluetooth` OpenRC service, supplied by the `net-wireless/rpi3-bluetooth` package (see [below](#bluetooth)).
   
   * **Tip:** <a id="add_bt_device"></a>to connect a new Bluetooth device to your RPi3/4 (a wireless mouse or keyboard, for example), first click on the Bluetooth icon in the top toolbar. When the `Bluetooth Devices` panel opens, click on <kbd>Search</kbd>, and make your device discoverable (this will usually involve pressing or holding a button or switch on the device itself), shortly after which it should appear in the listing. Once it does, click on it, then press <kbd>Setup...</kbd>, then ensure the `Pair Device` radio button is selected, and click <kbd>Next</kbd>. Then, if you are attaching a more complex device such as a keyboard, you'll see a PIN code notification message displayed (simpler devices, such as mice, often don't require a PIN for pairing, in which case no message will show). If you *are* prompted with a PIN, enter the code given into your device (for a keyboard, this normally means typing it in and pressing <kbd>Enter</kbd>). Once the devices are paired, you'll be prompted where to connect the device to: ensure the `Human Interface Device Service (HID)` radio button is selected, and click <kbd>Next</kbd>. Hopefully you will then see a message telling you `Device added and connected successfully`; click <kbd>Close</kbd> to dismiss it. With this done, your new device should start working. However, if you want to have it connect again automatically each boot, there's one more step you need to do. Click on your new device in the list (its icon should now be showing a key symbol, indicating that it is paired), and then click on the <kbd>Trust</kbd> shortcut button (the one that looks like a four-pointed gold star). With this done, your device setup is complete! You can add multiple interface devices to your RPi3/4 in this manner.

* The Pi uses the first (`vfat`) partition of the microSD card (`/dev/mmcblk0p1`) for booting. The various (closed-source) firmware files pre-installed there may are managed by the `sys-boot/rpi3-64bit-firmware` package (see [below](#boot_fw)). Once booted, this first partition will be mounted at `/boot`, and you may wish to check or modify the contents of the files `/boot/cmdline.txt` and `/boot/config.txt`.

* Because of licensing issues (specifically, [`bindist`](https://packages.gentoo.org/useflags/bindist) compliance), Mozilla Firefox Quantum has been distributed in its 'developer' edition - named 'Aurora'. Bear in mind that this app will take quite a long time (20 to 30 seconds on an RPi3, somewhat less on a an RPi4) to start on first use, as it sets up its local storage in `~/.mozilla/<...>`.
   * As your copy of Firefox is updated, you may see its title-bar name change sometimes to 'Nightly' (where that particular edition is taken from the [eponymous release channel](https://forums.gentoo.org/viewtopic-p-7304522.html#7304522)).
   * I have also pre-installed the lighter-weight Links browser on the image, in case you would like to use this in preference to Firefox.
   * For additional security, you can consider running Firefox inside an X11 `firejail` sandbox. See [these notes](https://wiki.gentoo.org/wiki/Sakaki%27s_EFI_Install_Guide/Sandboxing_the_Firefox_Browser_with_Firejail) for further details (the setup described therein *will* work on `arm64`; I use it configured that way on my own RPis).

* As of v1.3.1 of the image, the full-scale browser Chromium is also included on the image. For `bindist` compliance, I use a [modified](https://github.com/sakaki-/genpi64-overlay/blob/a8e84d5295bd49811456a953514521ba5efa01ba/www-client/chromium/chromium-76.0.3809.87-r1.ebuild#L476-L478) ebuild and [turn off](https://github.com/sakaki-/genpi64-overlay/blob/master/profiles/targets/rpi3/package.use/chromium) the patent-encumbered `h264` software codec.

* It is a similar story with the Mozilla Thunderbird mail client. Its `bindist`-compliant developer edition (installed on the image) is named 'Earlybird'.
  * Claws Mail has also been pre-installed on the image, if you want a lighter-weight, but still fully featured, mail client.

* By default, the image uses the Pi's [VC4 GPU](https://wiki.gentoo.org/wiki/Raspberry_Pi_VC4) acceleration (VC6 in the Pi4, although it still uses the `vc4...` kernel modules) in X, which has reasonable support in the 4.19.y kernel and the supplied userspace (via `media-libs/mesa` ultimately - this has been [tweaked](https://github.com/sakaki-/genpi64-overlay/blob/a8e84d5295bd49811456a953514521ba5efa01ba/media-libs/mesa/mesa-19.1.4-r1.ebuild#L413) 
on the image to include v3d support for the new Pi4). Note however that this is still work in progress, so you may experience issues with certain applications. The image (as shipped) uses the mixed-mode [`vc4-fkms-v3d`](https://www.raspberrypi.org/forums/viewtopic.php?f=29&t=159853) overlay / driver (see `/boot/config.txt`, or <kbd>Applications</kbd>&rarr;<kbd>Settings</kbd>&rarr;<kbd>RPi Config Tool</kbd>; you can change the driver if you wish to, or are experiencing serious glitches). On my RPi4 B at least, a `glxgears` score significantly in excess 1000fps can be obtained on an unloaded system  (~400fps on a loaded desktop). Incidentally, in normal use the main load is the Xfce window manager's compositor - try turning it off to see (via <kbd>Applications</kbd>&rarr;<kbd>Settings</kbd>&rarr;<kbd>Window Manager Tweaks</kbd>, <kbd>Compositor</kbd> tab) . YMMV - if you experience problems with this setup (or find that e.g. your system is stuck on the 'rainbow square' at boot time after a kernel update), you can fall-back to the standard framebuffer mode by commenting out the `dtoverlay=vc4-fkms-v3d` line in `/boot/config.txt` (i.e., the file `config.txt` located in the microSD card's first partition).
   > Kodi, VLC and SMPlayer have been pre-installed on the image, and they will all make use of accelerated (Mesa/gl) playback. Because of incompatibilities and periodic crashes when using it, XVideo (xv) mode has been disabled in the X server (`/etc/X11/xorg.conf.d/50-disable-Xv.conf`); this doesn't really impinge on usability. NB: **if you find video playback framerates too slow**, it is always worth **disabling the window manager's compositor** (see point immediately above) as a first step. Hint: for some video types, SMPlayer and Kodi perform significantly better than VLC, so if you do experience 'glitchy' playback with one media player, try using one of the others.

* As of v1.4.0 of this image, 'true' kms mode (`vc4-kms-v3d`) is usable for regular RPi users (this can be easily selected via <kbd>Applications</kbd>&rarr;<kbd>Settings</kbd>&rarr;<kbd>RPi Config Tool</kbd>). Please note that window manager compositing _should be turned off_ when using this mode, and accordingly, I have modified the existing [rpi3-safecompositor service](#safecompositor) to do this automatically.
   > For avoidance of doubt, **f**kms, the shipped default, is unaffected by this. Also please note that Pi-Top users should **not** use the 'true' kms mode; as Pi-Top speaker audio output is not supported under it. Also, since **f**kms mode is the factory default for the Buster release of Raspbian, it is likely to receive the most support going forward, and as such, my recommendation would be to stick with that.

* ALSA sound on the system is operative and routed by default through the headphone jack on the Pi. If you connect a sound-capable HDMI monitor (or television) sound should automatically also play through that device (in parallel) - at the moment there is only one 'master' volume control available.
   > In addition to Kodi, VLC and SMPlayer (all of which can play audio) the image also includes Clementine, which has good audio library support and is well integrated with on-line music services. NB - on first launch, Clementine sometimes fails to start, if it has difficulties creating its necessary database files. If this occurs, log out, log back in, and try launching Clementine again. Once it has first started successfully (for a given user) the issue disappears.
   
   > Hint: if you have headphones connected to your RPi3, but can't hear anything, issue (as the regular user, in a terminal) `amixer -c 0 cset numid=3 1` to force sound to route to the onboard jack (this will cause HDMI output to be muted too). Issue `amixer -c 0 cset numid=3 2` to turn HDMI audio output on again (muting the headphones).

* As of v1.5.0 of the image, full `pulseaudio` support has been built into all supplied packages (via a global USE flag).

* If you are using a Pi-Top chassis, have emerged `rpi-64bit-meta` with the `pitop` USE flag set, and have one or more pi-topSPEAKER units plugged in, the HDMI audio stream will [automatically play](https://github.com/sakaki-/genpi64-overlay#ptspeaker) though these. You should also be able to change the [screen backlight brightness](https://github.com/sakaki-/genpi64-overlay#ptbrightness) using the [keyboard buttons](https://github.com/sakaki-/genpi64-overlay#ptkeycuts), see the [remaining battery charge](https://github.com/sakaki-/genpi64-overlay#ptbattery) in the top panel, and find that the when you shut down your system, the hub [powers off](https://github.com/sakaki-/genpi64-overlay#ptpoweroff) your Pi-Top properly.
  * Pi-Top (v1) users: you can (at your option) swap out your existing RPi3 Model B board for a RPi3 Model B+; everything should work as before, but performance will be increased somewhat (the peak normal clock speed of the B+ is faster (at 1.4GHz) than the B (at 1.2GHz); also, the B+ includes a heat spreader, so is less prone to thermal throttling when worked hard). While you could in principle also use an RPi4 in the Pi-Top chassis, you'd need an adaptor for the microHDMI and power connectors, and you may also find the unit draws more power than the Pi-Top circuitry can supply, so this approach is not recommended.

* The frequency governor is switched to `ondemand` (from the default, `powersave`), for better performance, as of version 1.0.1. This is managed by the `sys-apps/rpi3-ondemand-cpufreq` package (see [below](#ondemand)).
  * If you are using an RPi3 Model B board, the frequency will switch dynamically between 600MHz and 1.2GHz, depending on load. On a Model B+, it will switch between 600MHz and 1.4GHz. On an RPi4, it will switch between 600MHz and 1.5GHz.

* On the RPi4, you can easily try *overclocking* your system, without voiding your warranty. To do so, open <kbd>Applications</kbd>&rarr;<kbd>Settings</kbd>&rarr;<kbd>RPi Config Tool</kbd> app, select the <kbd>Pi4 Tuning</kbd> tab, select an option from `Mid` to `Extreme` in the supplied 'manettino' ^-^, click <kbd>Save and Exit</kbd>, then elect to reboot when prompted. Note that you are likely to require active cooling for your RPi4 when overclocked, and it is always possible (although unlikely) that your device may fail to boot at the faster settings (if it does, simply edit the file `config.txt` on the first partition of the microSD card, comment out the `arm_freq` and `gpu_freq` settings, and try again).

* On the RPi4, please make sure your EEPROM firmware is up-to-date; there is (at the time of writing) an official update available (`0137a8.bin`) that can lower power consumption by around 300mW, which makes a significant difference to this somewhat [thermally challenged](https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=245703) ^-^ device. For more details please see [this post](https://www.raspberrypi.org/forums/viewtopic.php?p=1490467#p1490467).

* `PermitRootLogin yes` has explicitly been set in `/etc/ssh/sshd_config`, and `sshd` is present in the `default` runlevel. This is for initial convenience only - feel free to adopt a more restrictive configuration.

* I haven't properly tested suspend to RAM or suspend to swap functionality yet.

* As of version 1.0.1, all users in the `wheel` group (which includes `demouser`) have a passwordless sudo ability for all commands. Modify `/etc/sudoers` via `visudo` to change this, if desired (the relevant line is `%wheel ALL=(ALL) NOPASSWD: ALL`).

* As mentioned [above](#morespace), by default on first boot the image will attempt to automatically expand the root (second) partition to fill all remaining free space on the microSD card. If, for some reason, you elected _not_ to do this (and so renamed the sentinel file `autoexpand_root_partition` to `autoexpand_root_none` prior to first boot), you can easily expand the size of the second (root) partition manually, so that you have more free space to work in, using the tools (`fdisk` and `resize2fs`). See [these instructions](http://geekpeek.net/resize-filesystem-fdisk-resize2fs/), for example. I **strongly** recommend you do expand the root partition (whether using the default, first-boot mechanism or manually) if you are intending to perform large package (or kernel) builds on your Pi (it isn't necessary just to play around with the image of course).

* <a id="touchscreen"></a>If you are using the [official 7" touchscreen](https://www.element14.com/community/docs/DOC-78156/l/raspberry-pi-7-touchscreen-display) with your RPi3 (I have not tried it with an RPi4), you can rotate the display (and touch input) 180&deg; (to make it the right way up for the default case orientation) by appending `lcd_rotate=2` to `/boot/config.txt`, and restarting. Also, as of v1.1.3 of the image, the [`twofing`](http://plippo.de/p/twofing) daemon is included and will run automatically on startup; this lets you two-finger press to simulate right click, and also enables a limited repertoire of two-finger gestures (zoom/pinch, rotate, scroll etc.) within some apps. The daemon has no effect when the touchscreen is not connected. The `onboard` on-screen keyboard is also available (again, as of v1.1.3); activate it via <kbd>Applications</kbd>&rarr;<kbd>Accessories</kbd>&rarr;<kbd>Onboard</kbd>.
* As of version 1.2.0 of the image, the SPI interface has been activated (via `/boot/config.txt`); feel free to comment this out again if you need the GPIO lines it uses.
  * Additionally, as of 1.2.0, the necessary binaries for using your RPi3/4 to [disable the Intel Management Engine](https://wiki.gentoo.org/wiki/Sakaki's_EFI_Install_Guide/Disabling_the_Intel_Management_Engine) are now bundled with the image. Together with the above change, this allows your system to be used to run [`me_cleaner`](https://github.com/corna/me_cleaner) 'out of the box' (provided you have the correct [hardware connector and wires](https://wiki.gentoo.org/wiki/Sakaki's_EFI_Install_Guide/Disabling_the_Intel_Management_Engine#Prerequisites), of course). Users uninterested in this particular application are unaffected, and need take no action.

* The image uses the RPi3/4's hardware random number generator to feed `/dev/random` (via `sys-apps/rng-tools`); see [these notes](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-boot/rpi3-64bit-firmware) for further details.

* As a (limited, 64-bit) build of `media-libs/raspberrypi-userland` is included, you can use `vcgencmd` etc. As of version 1.5.2 of the image, this includes support for MMAL (including bundled tools such as `raspivid` and `raspicam`), although OpenMAX-IL is not yet supported from a 64-bit userland.

* If you wish to share files on a network with Windows boxes, please note that `net-fs/samba` is bundled as of version 1.2.2 of the image. To configure and activate it, please see e.g. [these notes](https://forums.gentoo.org/viewtopic-p-8215174.html#8215174).

* An `sysctl.d` rule (`35-low-memory-cache-settings.conf`) is used to modify the kernel cache settings slightly, for better performance in a memory constrained environment, per [these notes](https://www.codero.com/knowledge-base/pdf.php?cat=3&id=388&artlang=en).

* <a id="safecompositor"></a>As of version 1.2.2 of the image, a startup service (`rpi3-safecompositor`) is used to turn off display compositing if a high pixel clock is detected (> 1.2175MHz, currently), and an RPi3 is in use. This is because certain applications, for example LibreOffice v6 Draw and Impress, can cause the whole system to lock-up when used with compositing on under such conditions. The restriction does not apply to the RPi4.

* Also as of version 1.2.2, a startup service (`rpi3-ethfix`) is used to workaround certain RPi3B+ Ethernet issues via `ethtool`. It has no effect on RPi3B or RPi4 models.

* You can easily install (and run) 32-bit Raspbian apps on your 64-bit Gentoo system if you like (using `apt-get` from a `chroot`), since [ARMv8 supports mixed-mode userland](https://community.arm.com/processors/f/discussions/3330/how-aarch32-bit-applications-will-be-supported-on-aarch64?ReplyFilter=Answers&ReplySortBy=Answers&ReplySortOrder=Descending). If this interests you, please see my wiki entry on this subject, [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Running-32-bit-Raspbian-Packages-on-your-64-bit-Gentoo-System).

* To install source packages with resource-intensive build profiles, you can temporarily mount the image within a `binfmt_misc` QEMU user-mode `chroot` on your PC, and perform the `emerge` there. For further details, please see my wiki tutorial [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Build-aarch64-Packages-on-your-PC%2C-with-User-Mode-QEMU-and-binfmt_misc).

* If you would like to run **benchmarks** on your RPi3/4 system, please see [these notes](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Effective-Benchmarking-on-your-64-Bit-RPi-System).

* You can easily remove unwanted applications, and even the Xfce4 graphical desktop itself, from your 64-bit Gentoo system if desired. To do so, please refer to my notes [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Create-a-Slimmed-Down-Version-of-the-Image).

* If you are interested in a Docker variant of the image, please see necrose99's notes [here](https://github.com/necrose99/gentoo-on-rpi-64bit/tree/master/Dockerstuff).

* As of version 1.3.0 of the image, the weekly-gated rsync mirror URI has changed, to `rsync://isshoni.org/gentoo-portage-pi64-gem`. This mirror has no `porthash`  `repo.hash{,.asc}` files present in it, so may be checked by Portage's official `gemato` verification tool (and this will be done automatically for you during `genup` runs). The `porthash` tool itself (which previous versions of the image used for tree verification) has now been retired.
   > The old `rsync://isshoni.org/gentoo-portage-pi64` (non `-gem`) mirror will continue to be updated also for now, but will likely be withdrawn at some point in the future.

* As of version 1.2.2 of the image, you can efficiently run additional guest operating systems on your 64-bit Gentoo RPi3/4, using QEMU virtualization with KVM acceleration (much as you might use, say, VirtualBox on a PC). For further details, please see my wiki tutorial [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Run-Another-OS-on-your-RPi-as-a-Virtualized-QEMU-Guest-under-KVM). If you like, you can run a GUI, even a full desktop, on your guest OS, as further detailed [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Adding-a-GUI-to-your-QEMU-KVM-Guest-OS). Sample screenshot (with an Ubuntu 18.04 LTS guest):
  <img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi3/kvm-bionic-vnc.png" alt="[QEMU Guest Desktop with KVM Virtualization]" width="800px"/>
  <br>Notice how the guest and host OSes in the above are running different *kernels* - it's not just a `chroot`. On the higher-memory (2, 4 and 8GiB) RPi4 models, running a guest OS using KVM becomes quite a realistic proposition.

* If you'd like to remotely access your RPi3/4's desktop from another machine (whether a Linux PC, Windows PC, Mac or even another RPi!), you can do so easily, by using [VNC](https://en.wikipedia.org/wiki/Virtual_Network_Computing). Please see [these notes](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Run-a-Remote-VNC-Desktop-on-your-RPi) for further details.
  * For Windows users, [RDP](https://en.wikipedia.org/wiki/Remote_Desktop_Protocol) access is also supported (please see [these notes](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Access-your-RPi3%27s-Desktop-Remotely-from-a-Windows-Box-via-RDP) for further details).

* As of version 1.3.1 of the image, an Xfce4 startup service `rpi3-noblank` is active; this prevents the X11 screensaver from blanking the screen when it (i.e., the screensaver) is supposed to be turned off, as this can cause a mysterious 'black screen' (with no obvious way to recover, moving the mouse and keyboard don't work) under the `vc4-{f,}kms-v3d` graphics drivers.

* As of version 1.3.1 of the image, and as noted earlier, a simple tool, [`pyconfig_gen`](url=https://github.com/sakaki-/pyconfig_gen) has been provided, for easy (GUI-based) update of (a subset of the features contained in) the `/boot/config.txt` file on the RPi3. This utility is autostarted on first boot for each user. Changes made to the `/boot/config`.txt file using this application are subject to ratification on reboot; if you do not explicitly accept them before a short time limit expires, an automatic reboot under the prior, 'last known good' config is performed. This prevents you from locking yourself out by specifying (e.g.) an HDMI mode that is unsupported by your display (as an additional precaution against this particular case, only modes reported as being supported by the currently connected display are presented for selection in the GUI). Currently, only a small (but hopefully, useful) subset of the options available may be edited via this application, but this will be increased in future. It is still possible to directly edit `/boot/config.txt` via `nano` etc. - the app ignores keys it does not manage.
  * As of v1.5.0 of the image, you can use the `pyconfig_gen` tool to specify settings for a second screen, connected to the HDMI1 port on your Pi4 (these additional settings are ignored on the Pi3, which only has a single HDMI connector). To do so, open <kbd>Applications</kbd>&rarr;<kbd>Settings</kbd>&rarr;<kbd>RPi Config Tool</kbd>, select the <kbd>Second Display</kbd> tab, choose the appropriate settings just as you did for your main (HDMI0) display, then click <kbd>Save and Exit</kbd>, electing to reboot when prompted. Once your system comes back up, you can then confirm the settings (if OK),then click the <kbd>Launch Screen Layout Editor</kbd> to start the `arandr` program. This tool lets you set the relative rotation and layout of your two screens (side by side, stacked etc.), and you can apply these settings 'live' by clicking on the "green tickmark" toolbar button. Once you have a layout you like, you can persist it across reboots, by clicking the "save" toolbar icon (the rightmost one). If you save the settings to the location `~/.screenlayout/default.sh`, they will automatically be applied for you at each (graphical) login, for convenience. As of version 1.5.2 of the image, you can suppress this automatic application by holding down <kbd>Ctrl</kbd> during graphical startup.

* <a id="v4l2"></a>As of version 1.4.0 of the image, use of the Pi's hardware video codecs, and (optional) camera module, are both supported, via the [V4L2 framework](https://events.static.linuxfound.org/images/stories/pdf/lceu2012_debski.pdf). Two trivial applications (<kbd>Applications</kbd>&rarr;<kbd>Multimedia</kbd>&rarr;<kbd>RPi Camera Live View</kbd>, and <kbd>Applications</kbd>&rarr;<kbd>Multimedia</kbd>&rarr;<kbd>RPi Video Player (HW Codecs)</kbd>) are bundled to help demonstrate these features; a screenshot of these in use (running on an RPi3B+, with an attached Pi camera module v2, in a Pi-Top v1 chassis) is shown below:
  <img src="https://raw.githubusercontent.com/sakaki-/resources/master/raspberrypi/pi3/live-view-v4l2-codecs.jpg" alt="[Demonstrating Camera and Hardware Video Codec Access]" width="800px"/>
  <br>As of v1.5.0 of the image, these tools also work on an RPi4.<br>Given an appropriately patched `ffmpeg` (which is present in >=v1.4.0 of the image), exploiting these features from the command line is very simple - see the [example 'recipes'](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Using-the-RPi%27s-Video-Codecs-and-Camera-Module) (which work for both the RPi3 and RPi4) in this project's open [wiki](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki).

* <a id="mmal"></a>As of version 1.5.2 of the image, MMAL 64-bit userland support has been added, via the inclusion of 6by9's pointer-wrangling [PR#586](https://github.com/raspberrypi/userland/pull/586) into [`media-libs/raspberrypi-userland`](https://github.com/sakaki-/genpi64-overlay/blob/master/media-libs/raspberrypi-userland/files/raspberrypi-userland-1.20191121-64-bit-mmal.patch). As a result, tools such as `raspivid` and `raspistill` are bundled with the image (So now if, for example, you have the optional camera module attached, you should be able to issue e.g. `raspivid -v -o test.h264 -t 10000 -g 1`). (For those interested, OpenMAX-IL is not yet supported in 64-bit.)
  * Also from v1.5.2, the `mmal` USE flag for `media-video/ffmpeg` has been turned on, as the necessary support libraries and headers are now present (thanks to the above PR). So, for example, you could play back the above `test.h264` file using `ffplay -vcodec h264_mmal -i test.h264` (as well as via e.g. `ffplay -vcodec h264_v4l2m2m -i test.h264` of course, since the V4L2-M2M h/w codec endpoints remain supported too).

* If you'd like to install [Flatpak](https://en.wikipedia.org/wiki/Flatpak) apps on your RPi, please see [these notes](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Install-Flatpak-Applications-on-your-RPi) for further details.

* As of version 1.5.2 of the image, the [`rpi4-eeprom-updater`](https://github.com/sakaki-/genpi64-overlay/tree/master/dev-embedded/rpi4-eeprom-updater) service has been added, to automate the upgrading of the RPi4's bootloader and VL805 (USB) EEPROM firmware, patterned on the official [rpi-eeprom](http://archive.raspberrypi.org/debian/pool/main/r/rpi-eeprom/) deb. This service has no effect on the RPi3. For further details, please see [this post](https://www.raspberrypi.org/forums/viewtopic.php?p=1557653#p1557653).

* Also as of version 1.5.2, the `rpi-onetime-startup` service has been added. This runs the script `startup.sh` from the top-level directory of the FAT filesystem in partition 1, if present, on the first boot (after partition resizing), having first disabled itself from future invocation. It is particularly intended to allow e.g. initial networking to be configured for users of headless systems, and to that end the bundled `(/boot/)startup.sh` script contains a [number of (commented) examples](https://github.com/sakaki-/genpi64-overlay/blob/master/sys-apps/rpi-onetime-startup/files/startup.sh-2) of configuring the wired and wireless interfaces (using `nmcli`). To use, edit the `startup.sh` script (on e.g. a Windows or Linux desktop box) on the microSD card to which you have just written the image, prior to first using the card to boot your headless RPi3/4 (users booting the image on a system with attached mouse, keyboard and monitor do not need to do use this facility of course, since networking can be configured via the GUI, once booted).

* And also as of version 1.5.2, some of the core Gentoo system paths have changed, in line with [upstream](https://bugs.gentoo.org/378603), as follows (for more details, please see [this post](https://www.raspberrypi.org/forums/viewtopic.php?p=1569964#p1569964)):
  * `/usr/portage` -> `/var/db/repos/gentoo` (`$PORTDIR`)
  * `/usr/portage/distfiles` -> `/var/cache/distfiles` (`$DISTDIR`)
  * `/usr/portage/packages` -> `/var/cache/binpkgs` (`$PKGDIR`)
  * `/usr/local/portage/<overlay>` -> `/var/db/repos/<overlay>`

* If you'd like to set up a persistent dual-monitor setup on an RPi4, please see my short tutorial on this project's open wiki [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Set-Up-Dual-Displays-on-your-RPi4) (also contains some notes useful for single-display systems too).

* As of version 1.6.0, you can easily check and capture detailed network activity on your system, via <kbd>Applications</kbd>&rarr;<kbd>Internet</kbd>&rarr;<kbd>EtherApe</kbd> and <kbd>Applications</kbd>&rarr;<kbd>Internet</kbd>&rarr;<kbd>Wireshark</kbd>.

* Also as of version 1.6.0, a baseline set of packages for the FOSS videoconferencing server, **Jitsi**, is bundled. Please see [this post](https://forums.gentoo.org/viewtopic-p-8467370.html#8467370) for further instructions on setup and use (although you can of course skip the "RPi4 64-bit Gentoo Install" section there, as the necessary packages are already present on the image). You'll realistically require a 2GiB RPi4B (or better) to run this application successfully. Note, though, that since Jitsi does not process the video streams, but acts simply as a meeting coordination point, [selective forwarding unit](https://www.callstats.io/blog/webrtc-architectures-explained-in-5-minutes-or-less) and TURN server, the [CPU requirements are not onerous](https://jitsi.org/jitsi-videobridge-performance-evaluation/) - an RPi4 should be able to handle a reasonable number of simultaneous participants.

* And also as of version 1.6.0, you can dynamically switch the output route for audio (HDMI or headphones) by right-clicking the volume icon in the top panel bar (beside the clock) and selecting <kbd>Open Mixer</kbd> from the drop-down menu; you can then choose the route in the <kbd>Playback</kbd> tab's dropdown. 

## <a id="maintnotes"></a>Maintenance Notes (Advanced Users Only) (&darr;[skip](#miscpoints))

The following are some notes regarding optional maintenance tasks. The topics here may be of interest to advanced users, but it is not necessary to read these to use the image day-to-day.

> NB some of the following notes need updating for the new 1.6.0 image. I plan to do this shortly.

### <a id="revertkernelbin"></a>Optional: Switch Back to a 'Pure' `bcmrpi3_defconfig` / `bcm2711_defconfig` Kernel

As of version 1.2.2 of the image, the default binary kernel package has changed, to `sys-kernel/bcmrpi3-kernel-bis-bin`, the underlying kernel for which uses a slightly augmented version of the upstream `bcmrpi3_defconfig`, thereby enabling a number of useful additional facilities (such as KVM, ZSWAP etc). And, as of version 1.5.0 of the image, a *second* default kernel package is used, `sys-kernel/bcm2711-kernel-bis-bin`, the underlying kernel for which uses an augmented version of the upstream `bcm2711_defconfig` for the RPi4.

However, if you'd rather use the 'vanilla' `sys-kernel/bcm{rpi3,2711}-kernel-bin` (i.e., "pure" `bcm{rpi3,2711}_defconfig`) kernel packages, as was the case for <= v1.2.1 of the image, you can do so easily; simply become root, and issue:
```console
pi64 ~ # emerge --ask --verbose --oneshot sys-kernel/bcm{rpi3,2711}-kernel-bin
```

Once this completes, reboot immediately, and you'll be using the "old default" binary kernel packages again (and this choice will be respected during e.g. `genup` system update runs, going forward).

Switching back to the "-bis" binary kernel package pair, should you subsequently wish to do so, is just as straightforward; simply become root again and issue:
```console
pi64 ~ # emerge --ask --verbose --oneshot sys-kernel/bcm{rpi3,2711}-kernel-bis-bin
```

Reboot immediately the above command completes.

### <a id="kernelbuild"></a>Optional: Compiling a Kernel from Source

If you'd like to compile a kernel from source on your new system, rather than using the provided binary package, you can do so easily.

Because (at the time of writing) 64-bit support for the RPi3/4 is fairly 'cutting edge', you'll need to download the source tree directly, rather than using `sys-kernel/raspberrypi-sources`. You'll need to use at least version rpi-4.19.y (to get camera and [V4L2 M2M](https://events.static.linuxfound.org/images/stories/pdf/lceu2012_debski.pdf) access to the RPi3/4's hardware video codecs), with rpi-5.4.y preferred (and bundled as of version 1.6.0 of the image).

> Actually, you _can_ also use `sys-kernel/raspberrypi-sources` if you like, as that has a 4.19.9999 ebuild. However, to keep things straightforward, I have retained the 'direct clone' instructions in what follows.

The tree you need is maintained [here](https://github.com/raspberrypi/linux).

However first, since it generally makes sense to use a 'stable' branch compiler and `binutils` for kernel builds, but the RPi3/4 image uses the 'testing' (aka `~arm64`) branch for all packages by default, begin by downgrading your `gcc` compiler and `binutils` on the RPi3 to the 'stable' variants (these versions are also available on the binhost, so the following process shouldn't take long). Become root, and issue:
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
pi64 ~ # FEATURES="-getbinpkg" emerge --oneshot sys-devel/libtool
```

This process only needs to be done once. It won't affect your ability to build other packages on your RPi3/4.

> **NB:** if you are running Gentoo on a microSD card, please be sure that you have an expanded root partition (as described [above](#morespace)) on a >=16GB card, before attempting to build a kernel.

Now, suppose you wish to build the most modern version of the rpi-5.4.y kernel (same major/minor version as on the image). Then, begin by pulling down a [shallow clone](http://stackoverflow.com/q/21833870) of the desired version's branch from [GitHub](https://github.com/raspberrypi/linux) (users with sufficient bandwidth and disk space may of course clone the entire tree, and then checkout the desired branch locally, but the following approach is much faster).

Working logged in as your regular user, _not_ root (for security), issue:
```console
user@pi64 ~ $ mkdir -pv kbuild && cd kbuild
user@pi64 kbuild $ rm -rf linux
user@pi64 kbuild $ git clone --depth 1 https://github.com/raspberrypi/linux.git -b rpi-5.4.y
```

This may take some time to complete, depending on the speed of your network connection.

When it has completed, go into the newly created `linux` directory, and set up the baseline configuration. You'll actually need to build *two* kernels, one for the RPi3, another for the RPi4. So let's begin by building an RPi3 kernel, which uses `bcmrpi3_defconfig`. Issue:
```console
user@pi64 kbuild $ cd linux
user@pi64 linux $ make distclean
user@pi64 linux $ make bcmrpi3_defconfig
```

Next, modify the configuration if you like to suit your needs (this step is optional, as a kernel built with the stock `bcm{rpi3,2711}_defconfig` will work perfectly well for most users):
```console
user@pi64 linux $ make menuconfig
```
When ready, go ahead and build the kernel, modules, and dtbs. Issue:
```console
user@pi64 linux $ nice -n 19 make -j4 Image modules dtbs
```
This will a reasonable time to complete. (Incidentally, the build is forced to run at the lowest system priority, to prevent your machine becoming too unresponsive during this process.)

With the kernel built, we need to install it. Assuming your first microSD card partition is mounted as `/boot` (which, given the `/etc/fstab` on the image (visible [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/blob/master/reference/fstab)), it should be), become root.

Next, remove the provided binary kernel. Edit the file `/etc/portage/package.use/rpi-64bit-meta` so it reads (the relevant line is the last one):
```bash
# Enable/disable any metapackage USE flags you want here, and then
# re-emerge dev-embedded/rpi-64bit-meta to have the effect taken up
# e.g. you might set (uncommented):
#
#    dev-embedded/rpi-64bit-meta -weekly-genup
#
# to disable the automated weekly genup (package update)
# run.
#
# Unless you override them, the default metapackage flags are used.
# At the time of writing, those are (default flag status shown as + or -):
#
#  + boot-fw : pull in the /boot firmware, configs and bootloader
#  + kernel-bin : pull in the binary kernel package
#  - porthash : pull in repo signature checker, for isshoni.org rsync
#  + weekly-genup: pull in cron.weekly script, to run genup automatically
#  + innercore: pull in essential system packages for image (RPi initscripts etc.)
#  + core: pull in main packages for image (clang etc.) (requires innercore)
#  + xfce: pull in packages for baseline Xfce4 system (requires core)
#  - pitop: pull in Pi-Top support packages (NB most users will NOT want this;
#      the Pi-Top is a DIY laptop kit based around the RPi3) (requires xfce)
#  - apps: pull in baseline desktop apps (libreoffice etc.) (requires xfce)
#
# NB the main point of the core, xfce, pitop and apps USE flags is just to let
# you reduce what is in your @world set (/var/lib/portage/world).
dev-embedded/rpi-64bit-meta -kernel-bin
```

Then re-emerge the meta package, to delete the binary kernel package itself:
```console
pi64 ~ # emerge -v rpi-64bit-meta
pi64 ~ # emerge --depclean
```
> Important: do **not** try to restart your system yet - with the binary kernel uninstalled, you **must** install the new kernel (and DTBs and module set) you have just built, or the image will no longer boot. We will do that next.

Next, substituting your regular user's account name (the one you logged into when building the kernel, above) for `user` in the below, issue:
```console
pi64 ~ # cd /home/user/kbuild/linux
pi64 linux # cp -v arch/arm64/boot/Image /boot/kernel8.img
```

Note that by default, the kernel does _not_ require a separate U-Boot loader.

Next, copy over the device tree blobs (at the time of writing `arm64` was still using the `2710` dtb, but this may change to `2837` in future, so for safety, copy both of these, and also the RPi3 B+ and compute module 3 variants):
```console
pi64 linux # cp -v arch/arm64/boot/dts/broadcom/bcm{2710,2837}-rpi-3-b.dtb /boot/
pi64 linux # cp -v arch/arm64/boot/dts/broadcom/bcm2710-rpi-3-b-plus.dtb /boot/
pi64 linux # cp -v arch/arm64/boot/dts/broadcom/bcm2710-rpi-cm3.dtb /boot/
```

> Interestingly, even if you have a RPi3 B+, you don't *actually* need the `bcm2710-rpi-3-b-plus.dtb` dtb to boot it - the system's firmware will intelligently patch your standard `bcm2710-rpi-3-b.dtb` file, if that's all it can find. Nevertheless, it is better hygiene to include it.

Then, copy across the device tree overlay blobs (these are now the responsibility of the kernel, not the boot firmware, package, so it is essential you add them):
```console
pi64 linux # cp -rv arch/arm64/boot/dts/overlays/ /boot/
```

Lastly, install the modules:
```console
pi64 linux # make modules_install
pi64 linux # sync
```
> We **don't** do a `make firmware_install` here, since that build target [has been dropped](http://lkml.iu.edu/hypermail/linux/kernel/1709.1/04650.html) for >= 4.14.

Once that is done, we'll loop back and build and install the Pi4 kernel. Issue:

```console
user@pi64 linux $ make distclean
user@pi64 linux $ make bcm2711_defconfig
user@pi64 linux $ make menuconfig
```

Make sure to set `CONFIG_LOCALVERSION` to something distinct (like "-2711") to ensure the release names of the two kernels are distinct - you don't want their modules getting co-mingled in `/lib/modules/<kernel-release-name>/...`. Make any other changes you want, then save and exit the configuration tool, and issue:

```console
user@pi64 linux $ nice -n 19 make -j4 Image modules dtbs
```

Once done, copy across the kernel, dtb and modules (note the modified name used for the RPi4 kernel in `/boot`, to distinguish it from the RPi3 kernel (`kernel8.img`) that we built and copied over earlier):

```console
pi64 linux # cp -v arch/arm64/boot/Image /boot/kernel8-p4.img
pi64 linux # cp -v arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dtb /boot/
pi64 linux # make modules_install
```

There is no need to copy the `overlays` directory, as that is identical between the RPi3 and RPi4 64-bit builds, and you have already copied it over.

All done! After you reboot, you'll be using your new kernels.

It is also possible to cross-compile a kernel on your (Gentoo) PC, which is much faster than doing it directly on the RPi. Please see the instructions [later in this document](#heavylifting).
> Alternatively, if you set up `distcc` with `crossdev` (also covered in the instructions [below](#heavylifting)), you can call `pump make` instead of `make` to automatically offload kernel compilation workload to your PC. However, if you do use `distcc` in this way, be aware that not all kernel files can be successfully built in this manner; a small number (particularly, at the start of the kernel build) may fall back to using local compilation. This is normal, and the vast majority of files _will_ distribute OK.

If you want to switch **back** to the binary kernel package again, simply comment out the line you added at the end of `/etc/portage/package.use/rpi-64bit-meta`, and issue:
```console
pi64 ~ # emerge -v rpi-64bit-meta
```
You will receive warnings about file collisions (as the kernel package overwrites your `/boot/kernel8.img`, `/boot/kernel8-p4.img` etc.) but it should go through OK. Reboot, and you'll be using your binary kernels again!

> At this point, you may wish to clean up your old, source-built kernels' modules from `/lib/modules/<your-kernel-release-names>`, to save space.

### <a id="heavylifting"></a>Have your Gentoo PC Do the Heavy Lifting!

The RPi3 (and even the RPi4, although significantly better) does not have a particularly fast processor when compared to a modern PC. While this is fine when running the device in day-to-day mode (as a IME-free lightweight desktop replacement, for example), it does pose a bit of an issue when building large packages from source.
> Of course, as the (>= 1.1.0) image now has a weekly-autobuild [binhost](#binhost) provided, this will only really happen if you start setting custom USE flags on packages like `app-office/libreoffice`, or emerging lots of packages not on the [original pre-installed set](https://github.com/sakaki-/gentoo-on-rpi-64bit/blob/master/reference/world-all-packages).

However, there is a solution to this, and it is not as scary as it sounds - leverage the power of your PC (assuming it too is running Gentoo Linux) as a cross-compilation host!

For example, you can cross-compile kernels for your RPi3/4 on your PC very quickly (around 5-15 minutes from scratch), by using Gentoo's `crossdev` tool. See my full instructions [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Set-Up-Your-Gentoo-PC-for-Cross-Compilation-with-crossdev), [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Build-an-RPi4-64bit-Kernel-on-your-crossdev-PC) and [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Build-an-RPi3-64bit-Kernel-on-your-crossdev-PC) on this project's open [wiki](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki).

Should you setup `crossdev` on your PC in this manner, you can then take things a step further, by leveraging your PC as a `distcc` server (instructions [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Set-Up-Your-crossdev-PC-for-Distributed-Compilation-with-distcc) on the wiki). Then, with just some simple configuration changes on your RPi3 (see [these notes](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Set-Up-Your-RPi3-as-a-distcc-Client)), you can distribute C/C++ compilation (and header preprocessing) to your remote machine, which makes system updates a lot quicker (and the provided tool `genup` will automatically take advantage of this distributed compilation ability, if available).

> Since they share the same ARMv8a architecture (`march`), binaries built in this manner can be used on either a RPi3 Model B, B+ *or* an RPi4 Model B, without modification.

### <a id="rpi3_headless"></a>Using your RPi3/4 as a Headless Server

If you want to run a dedicated server program on your RPi3 or RPi4 (for example, a cryptocurrency miner), you won't generally want (or need) the graphical desktop user interface. To disable it, issue (as root):
```console
pi64 ~ # rc-update del xdm default
```

<a id="reclaim_mem"></a>You can also reclaim the memory reserved for the `vc4` graphics driver (this is optional). To do so, issue:
```console
pi64 ~ # nano -w /boot/config.txt
```

and comment out the following line, so it reads:
```ini
#dtoverlay=vc4-fkms-v3d
```

(Your setup may have a `cma` specification following the `vc4-fkms-v3d`; it's still the same line, and should be commented.)

Also ensure that the camera module support software is not loaded, and that only a minimal amount of GPU memory is allocated - to do so, ensure the below lines in the file read as follows:
```ini
#start_x=1
gpu_mem=16
```

Leave the rest of the file as-is. Save, and exit `nano`.

Reboot your system. You will now have a standard terminal login available only, which greatly saves on system resources.

> Should you wish to completely remove the graphical desktop's _packages_ from your system too, please see my notes [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki/Create-a-Slimmed-Down-Version-of-the-Image).

Next, ensure that your system won't autoupdate (since this can cause high system load at an unpredictable moment). Log in as root, then issue:
```console
pi64 ~ # echo "dev-embedded/rpi-64bit-meta -weekly-genup" > /etc/portage/package.use/rpi-64bit-meta
pi64 ~ # emerge -v rpi-64bit-meta
```

You can now arrange for your server program to start on boot, either by creating an explicit OpenRC service file in `/etc/init.d/` or by adding an (executable) startup script, named `/etc/local.d/<servicename>.start`, in which you fork off the server using `start-stop-daemon` (or similar).

> I recommend that you run your service at the *lowest* possible system priority (i.e., highest positive number niceness), particularly if it is CPU intensive. This will ensure that you're able to log in successfully using `ssh`, even if the daemon is in a tight CPU-bound loop.

It is generally more reliable to use the Ethernet rather than the WiFi network interface when running a headless server in this manner. Also, make sure your system has an adequate heatsink fitted (or even active CPU cooling, for particularly demanding applications), since the RPi3 (particuarly when running in 64-bit mode) can [get quite hot](https://www.theregister.co.uk/2017/10/18/active_cooling_a_raspberry_pi_3/), leading to thermal throttling or even protective system shutdown if your cooling is insufficient. The RPi3 Model B+ has a [integral heat-spreader](https://core-electronics.com.au/tutorials/raspberry-pi-3-model-b-plus-performance-vs-3-model-b.html), so (in addition to having a higher clock speed) it may be a somewhat better choice than the RPi3 Model B for more demanding applications. The RPi4 has [even more significant thermal challenges](https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=245703) than the RPi3, so active cooling is recommended for demanding applications.

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
```ini
dtoverlay=vc4-fkms-v3d
```

> With modern boot firmware, the recommendation is *not* to set an explicit `cma` parameter on `vc4-fkms-v3d`.

If you wish to use the camera, and hardware video codecs, also ensure that the below lines read as follows (if not, this step may be omitted):
```ini
start_x=1
gpu_mem=128
```

Leave the rest of the file as-is. Save, and exit `nano`. Reboot your system, and you should have your full graphical desktop back again!


## <a id="miscpoints"></a>Miscellaneous Points (Advanced Users Only) (&darr;[skip](#helpwanted))

The following are some notes about the detailed structure of the image. It is not necessary to read these to use the image day-to-day. <!--  -->


### RPi-Specific Ebuilds

As of version 1.1.0 of the image, all the required firmware and startup files have now been placed under ebuild control, for ease of maintenance going forward:
* <a id="metapackage"></a>A metapackage, [`sys-firmware/rpi-64bit-meta`](https://github.com/sakaki-/genpi64-overlay/tree/master/dev-embedded/rpi-64bit-meta) from the (subscribed) [`genpi64`](https://github.com/sakaki-/genpi64-overlay) ebuild repository (overlay) governs the inclusion of all the components discussed below (controlled by a set of USE flags). The version of the metapackage matches the version of the live-USB release to which it pertains.

  > For avoidance of doubt, by default the `rpi-64bit-meta` metapackage does _not_ specify the various end-user applications installed on the image (such as `libreoffice`, `firefox` etc.), so these may be freely uninstalled or modified as required (if you only intend to install *additional* applications however, you can specify the `apps` USE flag for `rpi-64bit-meta`, and then remove `libreoffice`, `firefox` etc from your @world set (`/var/lib/portage/world`).
* <a id="boot_fw"></a>The `/boot` firmware (_excluding_ the kernel and DTBs; _those_ are provided by `sys-kernel/bcm{rpi3,2711}-kernel<-bis>-bin`, discussed later) is provided by [`sys-boot/rpi3-64bit-firmware`](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-boot/rpi3-64bit-firmware): the upstream [`raspberrypi/firmware/boot`](https://github.com/raspberrypi/firmware/tree/master/boot) repo is checked once per week for new release tags, and a new corresponding ebuild created automatically if one is found. This package also pulls in (via [`sys-boot/rpi3-boot-config`](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-boot/rpi3-boot-config)) 'starter' configuration files `/boot/cmdline.txt` and `/boot/config.txt` (with settings matching those on the image), but these are `CONFIG_PROTECT`ed, so any changes you make subsequently will be preserved.
* <a id="wifi"></a>The configuration file `brcmfmac43430-sdio.txt`, required for the RPi3/4's integrated WiFi, is provided by [`sys-firmware/brcm43430-firmware`](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-firmware/brcm43430-firmware) (its main firmware being provided by the standard [`linux-firmware`](http://packages.gentoo.org/package/sys-kernel/linux-firmware) package).
   * This package now also provides the equivalent file `brcmfmac43455-sdio.txt`, for use with the RPi3 B+'s (and RPi4 B's) new [dual-band WiFi](https://www.raspberrypi.com.tw/tag/bcm2837/) setup (Cypress CYW43455), plus the `brcmfmac43430-sdio.clm_blob`.
   * The WiFi regulatory domain (initially set to `GB` on the image), is set by the `rpi3-wifi-regdom` service (provided by the [`net-wireless/rpi3-wifi-regdom`](https://github.com/sakaki-/genpi64-overlay/tree/master/net-wireless/rpi3-wifi-regdom) package); its value may be set by editing the file `/etc/conf.d/rpi3-wifi-regdom`, or (more conveniently) via the GUI-based <kbd>Applications</kbd>&rarr;<kbd>Settings</kbd>&rarr;<kbd>RPi Config Tool</kbd>, <kbd>WiFi</kbd> tab.
* <a id="bluetooth"></a>Firmware (`/etc/firmware/BCM43430A1.hcd`) for the RPi3/4's integrated Bluetooth transceiver is provided by [`sys-firmware/bcm4340a1-firmware`](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-firmware/bcm4340a1-firmware) (adapted from the Arch Linux [`pi-bluetooth`](https://aur.archlinux.org/packages/pi-bluetooth/) package). A startup service and `udev` rule are provided by the companion [`net-wireless/rpi3-bluetooth`](https://github.com/sakaki-/genpi64-overlay/tree/master/net-wireless/rpi3-bluetooth) package (adapted from the same Arch Linux upstream).
* <a id="ondemand"></a>The `/etc/local.d/ondemand_freq_scaling.start` boot script, which switches the RPi3/4 from its (`bcm{rpi3,2711}_defconfig`) default `powersave` CPU frequency governor, to `ondemand`, for better performance, has been switched to a `sysinit` OpenRC service, provided by [`sys-apps/rpi3-ondemand-cpufreq`](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-apps/rpi3-ondemand-cpufreq). On the RPi3 B, this allows the frequency to range up to 1.2GHz, and on the RPi3 B+, up to 1.4GHz, without overclocking. On the RPi4 B, this allows the frequency to range up to 1.5GHz without overclocking (and up to 2.0GHz with).
* <a id="init_scripts"></a>The `autoexpand_root_partition.start` script has been migrated into an OpenRC boot service, provided by [`sys-apps/rpi3-init-scripts`](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-apps/rpi3-init-scripts).
* <a id="expand-swap"></a>On first boot, after the root has been expanded, the default swapfile (at `/var/cache/swap/swap1`) will be auto-expanded to 1,024MiB if required, by [`sys-apps/rpi3-expand-swap`](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-apps/rpi3-expand-swap); configuration settings in `/etc/conf.d/rpi3-expand-swap`.
* <a id="zswap"></a>The `zswap` transparent compressing swap cache is set up by [`sys-apps/rpi3-zswap`](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-apps/rpi3-zswap); configuration settings in `/etc/conf.d/rpi3-zswap`.


### <a id="expedited_updates"></a>New Features to Expedite Regular System Updating

In addition to the above, as of version 1.1.0 of the image, a number of other changes have been made to expedite the process of keeping your 64-bit Gentoo RPi3 up-to-date:
* <a id="binary_kp"></a>An autobuild of the official [`raspberrypi/linux`](https://github.com/raspberrypi/linux) kernel (default branch) using `bcmrpi3_defconfig` has been set up [here](https://github.com/sakaki-/bcmrpi3-kernel); a new release tarball is automatically pushed once per week, and a matching kernel binary package ([`sys-kernel/bcmrpi3-kernel-bin`](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-kernel/bcmrpi3-kernel-bin)) is also created simultaneously. A variant of this with a slightly tweaked config is also maintained [here](https://github.com/sakaki-/bcmrpi3-kernel-bis) with binary kernel package ([`sys-kernel/bcmrpi3-kernel-bis-bin`](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-kernel/bcmrpi3-kernel-bis-bin)); this latter version is used by default as of v1.2.2 of the image.
  
  As of version 1.5.0 of the image, a parallel set of projects is maintained for the `bcm2711_defconfig` kernel used when booting an RPi4 (default autobuild [here](https://github.com/sakaki-/bcm2711-kernel-bis) with binary kernel package [here](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-kernel/bcm2711-kernel-bin), `-bis` autobuild [here](https://github.com/sakaki-/bcm2711-kernel-bis) with binary kernel package [here](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-kernel/bcm2711-kernel-bis-bin)).
  
  NB: at the time of writing, the `rpi-4.19.y` branch was the default (receiving most attention for backports etc.) Using `-bin` packages for the kernel makes it easy to switch between them (and to update your kernel, and module set, to the latest version available - along with all other packages on your system - whenever you issue `genup`); you can see the kernels available by issuing `eix bcm{rpi3,2711}-kernel-bis-bin`. Also, note that by default (via the `with-matching-boot-fw` USE flag) installing a particular `sys-kernel/bcm{rpi3,2711}-kernel<-bis>-bin` version will _also_ cause the version of `sys-boot/rpi3-64bit-firmware` (see [above](#boot_fw)) current at the time the kernel was released, to be installed (to `/boot`). This helps to reduce issues with firmware / kernel mismatches with cutting edge features such as VC4 support.
  Note also that via the (default) `pi3multiboot` flag, a matching-release `bcmrpi3-kernel-bis-bin` becomes a dep of `bcm2711-kernel-bis-bin`, so it suffices to work only with the latter (a similar USE flag is also available for the non-`bis` variants).

  > Use of the provided binary kernel packages is optional, you can always uninstall them (by editing the file `/etc/portage/package.use/rpi-64bit-meta`, setting the `-kernel-bin` USE flag, then issuing `emerge -v rpi-64bit-meta`) and [building your own kernel](#kernelbuild) instead, if desired.

* <a id="binhost"></a>The project's [Gentoo binhost](https://wiki.gentoo.org/wiki/Binary_package_guide) at https://isshoni.org/pi64pie has been reconfigured to perform a **weekly update and autobuild of all installed (userspace) packages on the image**, allowing your RPi3/4 to perform fast updates via the resulting binary packages where possible, only falling back to local source-based compilation when necessary (using this facility [is optional](#disable_weekly_update), of course, just like the binary kernel package). <a id="rsync"></a>The binhost also provides a (weekly-gated) `rsync` mirror (`rsync://isshoni.org/gentoo-portage-pi64-gem`) for the main `gentoo` repo (fully compatible with Gentoo's official `gemato` signed hash verification), used to keep your RPi3/4's "visible" ebuild tree in lockstep with the binary package versions available on the [isshoni.org](https://isshoni.org/pi64pie) binhost (incidentally, the `gentoo` repo on [isshoni.org](https://isshoni.org/pi64pie) itself is maintained against upstream using `webrsync-gpg`).
  > NB: I can make **no guarantees** about the future availability of the weekly autobuilds on [isshoni.org](https://isshoni.org/pi64pie), nor the autoupdated binary kernel packages (on GitHub). However, we use these as part of our own production infrastructure, so they should be around for a while. Use the provided binary packages at your own risk.

* <a id="profile"></a>A custom Gentoo profile, `genpi64:default/linux/arm64/17.0/desktop/genpi64`, is provided (and selected as the active profile on the image), which supplies many of the default build settings, USE flags etc., required for 64-bit Gentoo on the RPi3/4, again, keeping them in lockstep with the binhost (and ensuring you will have a binary package available when upgrading any of the pre-installed software packages on the image). You can view this profile (provided via the [genpi64](https://github.com/sakaki-/genpi64-overlay) ebuild repository) [here](https://github.com/sakaki-/genpi64-overlay/tree/master/profiles/targets/rpi3).
    > NB: as of release 1.2.0, the profile changed, from `rpi3:default/linux/arm64/13.0/desktop/rpi3` to `rpi3:default/linux/arm64/17.0/desktop/rpi3`, reflecting the underlying [Gentoo profile upgrade](https://www.gentoo.org/support/news-items/2017-11-30-new-17-profiles.html) from 13.0 to 17.0. Users of prior releases interested in manually upgrading should read [these notes](https://github.com/sakaki-/gentoo-on-rpi-64bit/releases#upgrade_to_profile_17). Then, as of release 1.5.0, the profile changed again, from `rpi3:default/linux/arm64/17.0/desktop/rpi3` to `genpi64:default/linux/arm64/17.0/desktop/genpi64`, reflecting a change in name of the main overlay (from `rpi` to `genpi64`). Users interested in this migration should read my transcribed news article [here](https://forums.gentoo.org/viewtopic-p-8362116.html#8362116).

<a id="why_weekly_update"></a>These features, viz.:
* the `genpi64:default/linux/arm64/17.0/desktop/genpi64` [profile](https://github.com/sakaki-/genpi64-overlay/tree/master/profiles/targets/rpi3),
* the weekly autobuild [isshoni.org binhost](https://isshoni.org/pi64pie),
* the 'weekly-gated', signature-authenticated portage rsync mirror (`rsync://isshoni.org/gentoo-portage-pi64-gem`), and
* the [`sys-kernel/bcmrpi3-kernel-bis-bin`](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-kernel/bcmrpi3-kernel-bis-bin) and [`sys-kernel/bcm2711-kernel-bis-bin`](https://github.com/sakaki-/genpi64-overlay/tree/master/sys-kernel/bcm2711-kernel-bis-bin) binary kernel packages;

make **updating a typical system (with few user-added packages) possible with a near 100% hit rate on the binhost's binaries**. As such, updating (via [`genup`](https://github.com/sakaki-/genup), for example, or an old-school `eix-sync && emerge -uDUav --with-bdeps=y @world`) is _much_ less onerous than before, and so has been **automated** on the image (via the `app-portage/weekly-genup` package, which installs a script in `/etc/cron.weekly`). This automated weekly updating can easily be disabled if you do not wish to use it (simply edit the file `/etc/portage/package.use/rpi-64bit-meta` and set the `-weekly-genup` USE flag, then `emerge -v rpi-64bit-meta`).

### Subscribed Ebuild Repositories (_aka_ Overlays)

The image is subscribed to the following ebuild repositories:
* **gentoo**: this is the main Gentoo tree of course, but is (by default) supplied via `rsync://isshoni.org/gentoo-portage-pi64-gem`, a weekly-gated, signature-authenticated portage rsync mirror locked to the binhost's available files, as described [above](#rsync).
* **[sakaki-tools](https://github.com/sakaki-/sakaki-tools)**: this provides a number of small utilities for Gentoo. The image currently uses the following ebuilds from the `sakaki-tools` overlay:
  * **app-portage/showem** [source](https://github.com/sakaki-/showem), [manpage](https://github.com/sakaki-/gentoo-on-rpi-64bit/blob/master/reference/showem.pdf)

    A tool to view the progress of parallel `emerge` operations.
  * **app-portage/genup** [source](https://github.com/sakaki-/genup), [manpage](https://github.com/sakaki-/gentoo-on-rpi-64bit/blob/master/reference/genup.pdf)

    A utility for keeping Gentoo systems up to date.
  * **app-portage/porthash** [source](https://github.com/sakaki-/porthash), [manpage](https://github.com/sakaki-/gentoo-on-rpi-64bit/blob/master/reference/porthash.pdf)

    Checks, or creates, signed 'master' hashes of Gentoo repos (useful when distributing via e.g. `rsync`). Retired as of version 1.3.0 of this image in favour of Gentoo's official `gemato` verification.
  * **sys-apps/me_cleaner** [upstream](https://github.com/corna/me_cleaner)

    A tool for partial deblobbing of Intel ME/TXE firmware images, used to disable the Intel Management Engine (ME). Now bundled with the image for convenience, for those who would like to use their RPi3 as an external programmer to reflash the firmware on their PC. See [these notes](https://wiki.gentoo.org/wiki/Sakaki's_EFI_Install_Guide/Disabling_the_Intel_Management_Engine) for further details.
  * **sys-apps/coreboot-utils** [upstream](https://www.coreboot.org)

    Provides some tools useful for inspection of Intel firmware images (used with `me_cleaner`, above).

  * **media-gfx/fotoxx** [upstream](https://www.kornelix.net/fotoxx/fotoxx.html)

    A program for improving image files from digital cameras (HDR etc). Supplies v19.13, which is not yet in the Gentoo tree.

* **[genpi64](https://github.com/sakaki-/genpi64-overlay)**: this overlay (which used to be named `rpi3` and was subsequently [migrated](https://forums.gentoo.org/viewtopic-p-8362116.html#8362116) at v1.5.0 with the advent of RPi4 support) provides ebuilds specific to the Raspberry Pi 3 & Pi 4, or builds that have fallen off the main Gentoo tree but which are the last known reliable variants for `arm64`. It also provides the [custom profile](#profile) [`genpi64:default/linux/arm64/17.0/desktop/genpi64`](https://github.com/sakaki-/genpi64-overlay/tree/master/profiles/targets/rpi3). A list of provided ebuilds may be found on the [overlay's project page](https://github.com/sakaki-/genpi64-overlay#list_of_ebuilds).

## <a id="projectwiki"></a>Project Wiki

In addition to the notes in this README, this project also has an associated open **wiki**, containing a number of short tutorial articles you may find helpful when using 64-bit Gentoo on your RPi3 or RPi4.

You can view the wiki homepage [here](https://github.com/sakaki-/gentoo-on-rpi-64bit/wiki). Feel free to add your own material!
  
## <a id="helpwanted"></a>Help Wanted!

You've got this far through the README - I'm impressed ^-^. In fact, you may be just the sort of person to help get `arm64` into a more stable state in the main Gentoo tree...

To that end, if you have managed to get additional packages (not included in the original [pre-installed set](https://github.com/sakaki-/gentoo-on-rpi-64bit/blob/master/reference/world-all-packages)) working reliably on your `gentoo-on-rpi-64bit` system, please feel free to submit PRs for the relevant [profile](#profile) elements of the [`genpi64` overlay](https://github.com/sakaki-/genpi64-overlay/tree/master/profiles/targets/rpi3) (for example, `package.accept_keywords`, `package.bashrc` and `package.use` entries). Not only will upstreaming your changes help other users in the short term, it will also create a shared knowledge base (about how to get various packages working on `arm64`) that can be used as a sourcebook for keywording PRs (etc.) to the main Gentoo tree.

Within reason, I'm also happy to consider adding working packages to the set maintained by the weekly-autobuild [binhost](#binhost); just open an [issue](https://github.com/sakaki-/gentoo-on-rpi-64bit/issues) to request this.

## Acknowledgement

I'd like to acknowledge NeddySeagoon's work getting Gentoo to run in 64-bit mode on the RPi3 (see particularly [this thread](https://forums.gentoo.org/viewtopic-t-1041352.html), which was a really useful reference when putting this project together originally).

## Feedback Welcome!

If you have any problems, questions or comments regarding this project, feel free to drop me a line! (sakaki@deciban.com)


