##resonalby workable example of a crossdev docker distcc for host. 


**FROM gentoo/stage3-amd64**  
Automatic public ebuild Docker allows container "fork's" or you to take an official Gentoo  base image , like a stage 3 and add on.. 

## some of the code was borrowed From debian distcc container. 
 
If you have a beffy server , or 10 core i7 etc or even a seldome used... wich can run docker as a container 
minimizes risks , anyhow this will create a crossdev/crossbuilder , workable example.. 

you can add packages like GOX if you like (Crossbuilds in go-lang) rust etc.. 

Minimal Gentoo stage 3 etc. in dockerhub you can add gentoo-portage to have /usr/portage... etc

Use and Abuse as a template.. 

'''emerge-webrsync && \
  USE="crossdev gssapi" emerge gcc  sys-devel/crossdev sys-devel/ct-ng sys-devel/icecream  && \

 
crossdev --ov-output /usr/local/portage -S -v -t armv7a-hardfloat-linux-gnueabi
crossdev --ov-output /usr/local/portage -S -v -t arm64-linux-gnu'''

 one can also get your loacal docker to Emerge arm64-linux-gnu  armv7a-hardfloat-linux-gnueabi  to ones liking and or binutils. 
 and or FROM ???/sakaki-distcc  echo in better useflags and rebuild. 
 ADDing on Mingw is also likely a posible, however note arm may build , arm64 windows patch may explode atm if trying to Cross to windows 10 on reg host machines. 
 https://wiki.gentoo.org/wiki/Mingw
