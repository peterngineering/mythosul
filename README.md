# mythosul
MythTV OS UltraLite

Currently: 
*This is bare bones mythtv v35*
You can run minimal frontend only or dyi builds with support for all the mythtv options.
Backend support is included and mariadb is included but comes un-enabled by default. 
The default mode is Frontend only startup.

(mythplugins are in the works, but getting perl working has been as they say in the UK, "A bugger!")
*drm/mesa3d dri have only been tested so far, but I have an original tinkerboard with a Cortex-a17 I might test.*
Also note:
currently, no X11 releases(but dyi rebuilds will support X/wayland with the right options chosen),
**currently working only on 32bit versions and only hardware that is capable of 32bit**
 *some of the following are 64bit/32bit chips* but the userland thus far will only be in 32bit.
    
**Tested/Working:**
* Rpi2 Cortex-a7 models
* Rpi3(also includes Rpi02W, RPi3A) Cortex-a53 models

 Soon to be tested 32bit capable models:
 * Rpi4 Cortex-a72
 * Rpi5 Cortex-a73
 
 **Orignal Rpi0/0w, too slow with only 1 core to work properly with VC4(so far)**
          **While it did work with the older stack(omx) it was only SDTV that worked anyway.**
              *Quick Note about the old stack vs new VC4, the rpi2-cortex-a7 works better with 720p/1080p mpeg2/mpeg4 on the new stack than it did the proprietary previous stack.*
              *If you want to play with the lowest power option, thats probably the RPi2 or the Rpi Zero2W*

Regarding Deinterlacing options within MythTV playback profiles and other general notes:
    On the older hardware you definately want to choose "LOW quality" for the double rate options or else "Video Playback Stuttering" will occur. With the forthcoming VC4-V3D rpi4/5 builds this *shouldn't* matter as much. While on the topic of good playback, using Wifi: You need a good strong stable signal or you will get substantial "Video Playback Stuttering" 


 *distros have 64bit available already in serveral flavors: Debian & derivatives, Enterprise Linux and Derivatives. I'm not trying to reproduce more builds of what already is easily available, but I may build a few 64 bit releases in the future for testing and comparison to these 32bit builds here.

DIY'er's/rebuilders Note:  Only the GCC toolchains are known to work, this is a mythtv specific limitation as my trials have shown all other packages upstream seem to build fine with Musl/UCLIBc as well, but YMMV.

These builds are for my amusement and testing/learning and no warranty is given or implied. 
You may ask for a feature or improvement but I may not be able to provide all and may refer you to build your own and test in order for me to impliment it, unless its very trivial ofc.


