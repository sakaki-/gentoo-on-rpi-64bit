## **A resonalby workable example of a crossdev docker distcc for host.** 
#### **to Do Improve the Template to Production & Genral Use... with a Built Image you can run anywhare... 

**FROM gentoo/stage3-amd64[https://hub.docker.com/r/gentoo/stage3-amd64/]**  

Automatic public ebuild Docker allows container **"fork's"** 
or you to take an **official Gentoo  base image** , like a stage 3 and ***add on.. as you like.***

#### some of this code was borrowed From debian distcc & Sabayon Linux  containers. 
 
If you have a beffy server , or 10 core i7 etc or even a seldome used... wich can run docker as a container 
minimizes risks , anyhow this will create a crossdev/crossbuilder , workable example.. 

you can add packages like **GOX** if you like (Crossbuilds in go-lang) **rust** etc.. 

Minimal Gentoo stage 3 etc. in dockerhub you can add gentoo-portage to build  to have /usr/portage... etc volume , and is automated so lest gets less stale...

**Use and Abuse This as a Docker  template.. **

#### So Far image is quite Basic In Template 
'''emerge-webrsync && \
  USE="crossdev gssapi" emerge gcc  sys-devel/crossdev sys-devel/ct-ng sys-devel/icecream  && \

crossdev --ov-output /usr/local/portage -S -v -t armv7a-hardfloat-linux-gnueabi
crossdev --ov-output /usr/local/portage -S -v -t arm64-linux-gnu'''

 <br>one can also get your loacal docker to Emerge arm64-linux-gnu  armv7a-hardfloat-linux-gnueabi  to ones liking and or binutils. 
 and or FROM ???/sakaki-distcc  echo in better useflags and rebuild.
 
<br> ADDing on Mingw is also likely a posible, however note arm may build , **arm64 windows 10 iot** patch may explode atm if trying to Cross to windows 10 on reg host machines.
 
<br> also might be a future step to add Run ./buld.sh to do more improved on a public image.. 
 
 <br>if you have a repo or binhost or https://cloudsmith.io you can also build them in chroot , &  ADD  package-URL  /usr/portage/packages/..... 
 run del after emerge /usr/portage/packages/..... tarball   if you wish to "boot strap"
 
 https://github.com/sakaki-/gentoo-on-rpi3-64bit/wiki/Set-Up-Your-RPi3-as-a-distcc-Client  IT goes without saying.... wise to use this asap... 
 *IT takes a bit of tinkering but I plan on getting a good bit of that here. soon.* 
 
 ####however if you have a **few machines** and or **Docker-Swawm** , you can prety much cluster docker containers. or feal 
 Meh I don't want to install on 5-6 machines ... but can run docker on many machines before kicking off a build... as well docker is ephemeral so wont have to run clean up scripts if thiers artifacts on distcc dockerhosts.. 
 **Docker-Swawm**  also nice if your lucky enough to have an ISP or some-hosting.com Datacenter, enterpise Corp dev.. to abuse time to time... 
 
 #### https://wiki.gentoo.org/wiki/Mingw  could as well Add Ming to crossbuild for windows , Arm or arm64 is slowly ...  , and or for **pentesting Things** 
 
 #### RUSTLANG  used offten for mozilla. 
  **https://github.com/japaric/cross**  **https://crates.io/crates/cargo-ebuild** would also allow an ebuild for crossing rust..
  Caro-ebuild can offten make ebuilds for a number of things. 
