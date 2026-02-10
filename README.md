[![FFmpeg Win-ARM64 Auto-Builds](https://github.com/tordona/ffmpeg-win-arm64-test/actions/workflows/main.yml/badge.svg)](https://github.com/tordona/ffmpeg-win-arm64-test/actions/workflows/main.yml)

# ffmpeg-win-arm64
FFmpeg builds for Windows ARM64 (Qualcomm Snapdragon)

## Stable Releases
Stable releases are based on last two major releasees, with current minor and patch.  

[https://github.com/tordona/ffmpeg-win-arm64/releases/tag/8.0.1](https://github.com/tordona/ffmpeg-win-arm64/releases/tag/8.0.1)

[https://github.com/tordona/ffmpeg-win-arm64/releases/tag/7.1.3](https://github.com/tordona/ffmpeg-win-arm64/releases/tag/7.1.3)

## Latest Release
Latest releases provide consistent URLs always pointing to the latest build available (most recent daily build).

[https://github.com/tordona/ffmpeg-win-arm64-test/releases/tag/latest](https://github.com/tordona/ffmpeg-win-arm64-test/releases/tag/latest)

## Daily Releases
Daily releases are automatically build based on latest Github commits at the time. These are available for up-to 14 days.

## Builds
There are a few variants offered. The essentials build variant contains commonly used libraries, whereas the full build variant also contains most of the remainder. See the libraries section for a list. All variants contain all internal components available for Windows. If you're downloading a package to support features in a program like Shotcut or Adacity, the essentials shared build is sufficient.

## Libraries

libraries in essentials build  
`
avisynth  vapoursynth  libaom  libass  libfreetype  libfribidi  libharfbuzz  libgme  libgsm  libmp3lame  libopencore-amrnb  libopencore-amrwb  libopenjpeg  libopenmpt  libopus  librubberband  libspeex  libsrt  libssh  libtheora  libvidstab  libvmaf  libvo-amrwbenc  libvorbis  libvpx  libwebp  libx264  libx265  libxvid  libzimg  libzmq  mediafoundation  openal  sdl2
`

additional libraries in full build  
`
chromaprint  frei0r  ladspa  lcms2  libaribb24  libaribcaption  libbluray  libbs2b  libcaca  libcdio  libcodec2  libdav1d  libdvdnav  libdvdread  libilbc  libjxl  liblc3  libmodplug  libmysofa  libplacebo  libqrencode  librav1e  librist  libshaderc  libshine  libsnappy  libsoxr  libsvtav1  libtwolame  libxevd  libxeve  libzvbi  opencl  vulkan  whisper liboapv
`

libraries not yet supported  
`
libdavs2
libflite
liblensfun
libquirc
libuavs3d
libxavs2
`

hardware-support libraries in all builds  
`
amf d3d11va d3d12va dxva2 vaapi
`

## Library Versions
As of, 2026.02.10, these are documented in each respective archive within the `readme.txt` file.

## Building from source
See [BUILDING.md](BUILDING.md)

## Additional Resources 

* [FFmpeg](https://www.ffmpeg.org) - Official Website
* [MSYS2](https://www.msys2.org) - Software Distribution and Building Platform for Windows
* [Additional MSYS PKGBUILDs](https://github.com/tordona/mingw-packages) - Modified Packages for FFmpeg building on Windows
* [CODEX FFMPEG](https://www.gyan.dev/ffmpeg/builds/) - Visit for all other Windows x64 FFmpeg variants
* [FFmpeg-Builds](https://github.com/BtbN/FFmpeg-Builds) - Builds of FFmpeg for Windows and Linux
* [https://osxexperts.net](https://osxexperts.net) - FFmpeg static build for macOS 


