[![FFmpeg Win-ARM64 Auto-Builds](https://github.com/tordona/ffmpeg-win-arm64-test/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/tordona/ffmpeg-win-arm64-test/actions/workflows/main.yml)



## Compiling FFmpeg for Windows using MSYS2 Environment

This is a general walk-through for compiling a local build of FFmpeg on Microsoft Windows. This guide specifically targets the ARM64 architecture, but can be applied to x64 architecture with slight modifications.

## Prerequisites

* Device runing Windows on ARM
* [Windows 11 ARM, minimum 24H2](https://www.microsoft.com/en-us/software-download/windows11arm64) 
* [MSYS2](https://www.msys2.org/)
* [FFmpeg source code](https://github.com/FFmpeg/FFmpeg)


## General Compilation Steps
**1. Install Required MSYS2 Environment**  
Visit https://www.msys2.org/docs/arm64/ for instructions and download links.

*Unless noted, all of the commands should be run within the `CLANGARM64` shell environment.*

**2. Launch and update Environment tools**  
- Execute `clangarm64.exe` in the MSYS2 install directory
- Update MSYS2

```
pacman -Suy
```

**3. Install tooling and dependencies**  
You need basic development tools, compilers, and libraries to get started. Use `pacman` the [package management](https://www.msys2.org/docs/package-management/) of MSYS2 to install these items.

standard packages:
```
pacman -S gcc git make
```

architecture specific packages and toolchains:
```
pacman -S mingw-w64-clang-aarch64-{toolchain,gcc-compat,diffutils,libssh2,texinfo}
```
  
**4. Download the source code**  
Clone the official repository using Git:  
```
git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg
```

**5. Create a build directory**  
Recommend to create a directory to store the compiled FFmpeg build, that's outside of the source directory.

```
mkdir ffmpeg_builds
```

**5. Configure FFmpeg**  
Run the `configure` script inside the source directory to prepare the build environment.  
To start, use the `prefix` option to specify where the build will be stored.  
Next, pass in a few flags to properly link necessary libraries.  

```
cd ffmpeg
./configure --prefix='~/ffmpeg_builds' --extra-libs='-static' --pkg-config-flags='--static'
```

Be patient. The `configure` process may take several minutes to finish before andy status change.  
  
  
**6. Compile the Source**  
Start the compilation by calling `make` and pass the jobs argument `-j$(nproc)`.  
`nproc` will return the number of processing units available on your device.  

```
make -j$(nproc)
```

**7. Install**  
Installing involves calling `make` command with the `install` directive.  
The compiled binaries will be installed to the specified `prefix` (~/ffmpeg_builds). 

```
make install
```

**9. Run the executable**  
Run the installed version to ensure compilcation finished. It is typically installed to a parent directory named `bin`
```
cd ~/ffmpeg_builds/bin
./ffmpeg.exe
```

**10. Congratulations**  
If all was succesful, a generic standard version of FFmpeg was just created specific to your Windows device.

## Getting Customized
`./configure --help` will give a list of all available options that can disabled or enabled. To enable a library, the dependencies need to be install via `pacman`  

To enable the option `libmp3lame`, first install the library:
```
pacman -S mingw-w64-clang-aarch64-lame
```

then add the switch to configration options:
```
./configure [...other-options and flags] --enable-libmp3lame
```

## Mappings
This is a partial mapping of FFmpeg options to MSYS2 Packages.  

`--enable-[FFmpeg_Option]`  

`pacman -S mingw-w64-clang-aarch64-[MSYS2_Package]`  

<table>
  <thead>
     <tr>
        <th>FFmpeg Option</th>
        <th>Min Version</th>
        <th>MSYS2 Package</th>
        <th>Static</th>
     </tr>
  </thead>
  <tbody>
     <tr>
        <td>chromaprint</td>
        <td>7</td>
        <td>chromaprint</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>fontconfig</td>
        <td>7</td>
        <td>fontconfig</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>frei0r</td>
        <td>7</td>
        <td>frei0r-plugins</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>ladspa</td>
        <td>7</td>
        <td>ladspa-sdk</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>ladspa</td>
        <td>7</td>
        <td>dlfcn</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>lcms2</td>
        <td>7</td>
        <td>lcms2</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libaom</td>
        <td>7</td>
        <td>aom</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libaribb24</td>
        <td>7</td>
        <td>aribb24</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libaribcaption</td>
        <td>7</td>
        <td>libaribcaption</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libass</td>
        <td>7</td>
        <td>libass</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libbluray</td>
        <td>7</td>
        <td>libbluray</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libbs2b</td>
        <td>7</td>
        <td>libbs2b</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libcdio</td>
        <td>7</td>
        <td>libcdio</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libcdio</td>
        <td>7</td>
        <td>libcdio-paranoia</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libcodec2</td>
        <td>7</td>
        <td>codec2</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libdav1d</td>
        <td>7</td>
        <td>dav1d</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libdvdnav</td>
        <td>7</td>
        <td>libdvdnav</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libdvdread</td>
        <td>7</td>
        <td>libdvdread</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libfreetype</td>
        <td>7</td>
        <td>freetype</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libfribidi</td>
        <td>7</td>
        <td>fribidi</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libgme</td>
        <td>7</td>
        <td>libgme</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libgsm</td>
        <td>7</td>
        <td>gsm</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libharfbuzz</td>
        <td>7</td>
        <td>harfbuzz</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libilbc</td>
        <td>7</td>
        <td>libilbc</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libjxl</td>
        <td>7</td>
        <td>libjxl</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libkvazaar</td>
        <td>7</td>
        <td>kvazaar</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>liblc3</td>
        <td>7</td>
        <td>liblc3</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libmodplug</td>
        <td>7</td>
        <td>libmodplug</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libmp3lame</td>
        <td>7</td>
        <td>lame</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libmysofa</td>
        <td>7</td>
        <td>libmysofa</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>liboapv</td>
        <td>8</td>
        <td>openapv</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libopencore-amrnb</td>
        <td>7</td>
        <td>opencore-amr</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libopencore-amrwb</td>
        <td>7</td>
        <td>opencore-amr</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libopenh264</td>
        <td>7</td>
        <td>openh264</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libopenjpeg</td>
        <td>7</td>
        <td>openjpeg2</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libopenmpt</td>
        <td>7</td>
        <td>libopenmpt</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libopus</td>
        <td>7</td>
        <td>opus</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libplacebo</td>
        <td>7</td>
        <td>libplacebo</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libqrencode</td>
        <td>7</td>
        <td>qrencode</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>librav1e</td>
        <td>7</td>
        <td>rav1e</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>librist</td>
        <td>7</td>
        <td>librist</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>librubberband</td>
        <td>7</td>
        <td>rubberband</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libshaderc</td>
        <td>7</td>
        <td>shaderc</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libshine</td>
        <td>7</td>
        <td>shine</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libsnappy</td>
        <td>7</td>
        <td>snappy</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libsoxr</td>
        <td>7</td>
        <td>libsoxr</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libspeex</td>
        <td>7</td>
        <td>speex</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libsrt</td>
        <td>7</td>
        <td>srt</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libssh</td>
        <td>7</td>
        <td>libssh</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libsvtav1</td>
        <td>7</td>
        <td>svt-av1</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libtheora</td>
        <td>7</td>
        <td>libtheora</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libtwolame</td>
        <td>7</td>
        <td>twolame</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libvidstab</td>
        <td>7</td>
        <td>vid.stab</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libvmaf</td>
        <td>7</td>
        <td>vmaf</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libvo-amrwbenc</td>
        <td>7</td>
        <td>vo-amrwbenc</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libvorbis</td>
        <td>7</td>
        <td>libvorbis</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libvpx</td>
        <td>7</td>
        <td>libvpx</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libwebp</td>
        <td>7</td>
        <td>libwebp</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libx264</td>
        <td>7</td>
        <td>libx264</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libx265</td>
        <td>7</td>
        <td>x265</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libxevd</td>
        <td>7</td>
        <td>xevd</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libxeve</td>
        <td>7</td>
        <td>xeve</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libxvid</td>
        <td>7</td>
        <td>xvidcore</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>libzimg</td>
        <td>7</td>
        <td>zimg</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libzmq</td>
        <td>7</td>
        <td>zeromq</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>libzvbi</td>
        <td>7</td>
        <td>zvbi</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>mediafoundation</td>
        <td>7</td>
        <td>qt6-multimedia-wmf</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>openal</td>
        <td>7</td>
        <td>openal</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>opencl</td>
        <td>7</td>
        <td>opencl-icd</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>sdl2</td>
        <td>7</td>
        <td>SDL2</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>vapoursynth</td>
        <td>7</td>
        <td>vapoursynth</td>
        <td align="center">✅</td>
     </tr>
     <tr>
        <td>vulkan</td>
        <td>7</td>
        <td>vulkan-loader</td>
        <td align="center">⚠️</td>
     </tr>
     <tr>
        <td>whisper</td>
        <td>8</td>
        <td>whisper.cpp</td>
        <td align="center">⚠️</td>
     </tr>
  </tbody>
</table>
