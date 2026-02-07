[![FFmpeg Win-ARM64 Auto-Builds](https://github.com/tordona/ffmpeg-win-arm64-test/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/tordona/ffmpeg-win-arm64-test/actions/workflows/main.yml)

## Compiling FFmpeg for Windows using MSYS2 Environment  
This is a general walk-through for compiling a local build of FFmpeg on Microsoft Windows. This guide specifically targets the ARM64 architecture, but can be applied to x64 with slight modifications.

## Prerequisites

* **Hardware:** A device running Windows on ARM.
* **OS:** [Windows 11 ARM, minimum 24H2](https://www.microsoft.com/en-us/software-download/windows11arm64).
* **Environment:** [MSYS2](https://www.msys2.org/)
* **Source:** [FFmpeg](https://github.com/FFmpeg/FFmpeg)

## General Compilation Steps

### 1. Install Required MSYS2 Environment
Visit the [MSYS2 ARM64 Documentation](https://www.msys2.org/docs/arm64/) for specific installation instructions and download links.

> [!IMPORTANT]
> Unless otherwise noted, all commands must be executed within the **`CLANGARM64`** shell environment.

### 2. Launch and Update Environment Tools
1. Execute `clangarm64.exe` located in your MSYS2 installation directory.
2. Update the package database and core system packages:
   ```bash
   pacman -Suy
   ```

### 3. Install tooling and dependencies  
Several basic development tools, compilers, and libraries are needed to begin. Use `pacman` to install the following items.

Standard packages:
```
pacman -S gcc git make
```

Architecture-specific packages:
```
pacman -S mingw-w64-clang-aarch64-{toolchain,gcc-compat,diffutils,libssh2,texinfo}
```
  
### 4. Download the source code
Clone the official repository using Git:  
```
git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg
```

### 5. Create a build directory  
It is recommended to create a separate directory to store the compiled FFmpeg build outside of the source tree.

```
mkdir $HOME/ffmpeg_builds
```

### 6. Configure FFmpeg
Run the `configure` script inside the source directory to prepare the build environment. We use the `--prefix` option to specify the installation path and flags to link libraries statically.

```
cd ffmpeg
./configure --prefix='$HOME/ffmpeg_builds' --extra-libs='-static' --pkg-config-flags='--static'
```

_Be patient. The `configure` process may take several minutes to finish before any status change._
  
### 7. Compile the Source  
Start the compilation by calling `make`. The -`j$(nproc)` argument utilizes all available processing units on your device to speed up the build.

```
make -j$(nproc)
```

### 9. Install  
Run the `install` directive to move the compiled binaries to your specified prefix directory ($HOME/ffmpeg_builds).

```
make install
```

### 10. Verify the Installation
Run the newly created executable to ensure the compilation was successful.
```
cd $HOME/ffmpeg_builds/bin
./ffmpeg.exe -version
```

### 10. Congratulations
If the version information appears, you have successfully created a simplified version of FFmpeg optimized specifically for your Windows ARM device.

## Customization
To see a full list of available options, run `./configure --help`. To enable a specific library, the dependencies must be installed via `pacman` first.

1. Install the library:
```
pacman -S mingw-w64-clang-aarch64-lame
```

2. Add the switch to your configuration:
```
./configure [...other-options and flags] --enable-libmp3lame
```

## Package Mappings
The following table provides a partial mapping of FFmpeg options to their corresponding MSYS2 packages.

Usage:
* FFmpeg Option: `--enable-[Option]`
* MSYS2 Package: `pacman -S mingw-w64-clang-aarch64-[Package]`

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
