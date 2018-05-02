#/bin/bash
# refrance https://github.com/olsonbg/crossdev-gentoo , /usr/local/mingw-crossdev/ used insted so different toolchains wont clobber
# each other...
## trying to see if ming on arm/arm64 will work is mad-science at this point. but why not give it a try.
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm:' > /proc/sys/fs/binfmt_misc/register
 
echo initilizing mingw-pc/& arm-pc , Do note that windows 10 arm/arm64 is quite experamental... 
 
crossdev -t x86_64-pc-mingw32 --stable --init-target -oO /usr/local/mingw-crossdev/
crossdev -t i686-pc-mingw32 --stable --init-target -oO /usr/local/mingw-crossdev/
# arm targest 
crossdev -t aarch64-pc-mingw32 --stable --init-target -oO /usr/local/mingw-crossdev/
crossdev -S -v -t armv7a-hardfloat-pc-mingw32 --stable --init-target -oO /usr/local/mingw-crossdev/
 
## fire up crossdev
crossdev -t x86_64-pc-mingw32 --stable -oO /usr/local/mingw-crossdev/
crossdev -t i686-pc-mingw32 --stable -oO /usr/local/mingw-crossdev/
crossdev -t aarch64-pc-mingw32 --stable -oO /usr/local/mingw-crossdev/
crossdev -t armv7a-hardfloat-pc-mingw32 --stable -oO /usr/local/mingw-crossdev/
#bootstrap... Porthole to get more sexy ie cgo pie etc.. 
## arm64 Minggoing to be markerdly unstable.. but for a weekly run , it''l ?Eventually fix it self.. perhaps..
crossdev -v -t x86_64-pc-mingw32 --genv 'USE="cxx multilib fortran -mudflap nls openmp -sanitize"' -oO /usr/local/mingw-crossdev/
crossdev -v -t i686-pc-mingw32 --genv 'USE="cxx multilib fortran -mudflap nls openmp -sanitize"' -oO /usr/local/mingw-crossdev/
# arm targets,, ## coment out if not WANTED... 
crossdev -v -t armv7a-pc-mingw32 --genv 'USE="cxx multilib fortran -mudflap nls openmp -sanitize  objc objc++ objc-gc graphite pgo vtv cilk go pie"' -oO /usr/local/mingw-crossdev/
crossdev -v -t aarch64-pc-mingw32 --genv 'USE="cxx multilib fortran -mudflap nls openmp -sanitize  objc objc++ objc-gc graphite pgo vtv cilk go pie"' -oO /usr/local/mingw-crossdev/
