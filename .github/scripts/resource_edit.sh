echo "Resource Edit FF*"
pwd
if [[ -z $root_path && -z $version_name ]]; then
    if [[ -d "$root_path/$version_name/bin" ]]; then
        cd "$root_path/$version_name/bin"
    else
        echo "no path available"
        exit 1
    fi
else
    echo "no path or version"
    exit 1
fi

if [[ ! -f "./utilities/rcedit.exe" ]]; then
    echo "rcedit not found"
    exit 1
fi

version="$github_tag"
build_date=$(date '+%Y.%m.%d.0')
file_version="$build_date"
copyright="Copyright © 2000-$(date '+%Y') the FFmpeg developers"
ffmpeg_desc="A command line tool to convert multimedia files between formats"
ffplay_desc="A simple media player based on SDL and the FFmpeg libraries"
ffprobe_desc="A simple multimedia stream analyzer"

ff_progs=(
    "ffmpeg"
    "ffplay"
    "ffprobe"
)

for ff in "${ff_progs[@]}"; do
    desc=$ff
    desc+="_desc"
    if [[ -f "${ff}.exe" ]]; then
        product_prefix=${ff:0:2}
        product_suffix=${ff:2}
        ./utilities/rcedit.exe ${ff}.exe --set-version-string "FileDescription" "${!desc}"
        ./utilities/rcedit.exe ${ff}.exe --set-file-version "${file_version}"
        ./utilities/rcedit.exe ${ff}.exe --set-version-string "ProductName" "${product_prefix^^}${product_suffix}"
        ./utilities/rcedit.exe ${ff}.exe --set-version-string "ProductVersion" "${version}"
        ./utilities/rcedit.exe ${ff}.exe --set-version-string "LegalCopyright" "${copyright}"
        if [[ -f "${ff}.ico" ]]; then
            ./rcedit.exe ${ff}.exe --set-icon ${ff}.ico
        fi
    fi
done