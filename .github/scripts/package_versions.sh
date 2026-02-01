path="$output_path/$version_name"
file="$path/packages.txt"
for package in $packages; do
    pkg_info=$(pacman -Qi "$package" 2>&1 | head -n 3)
    if [[ $pkg_info != "error"* ]]; then
        modified_info="${pkg_info/$package_prefix-/}"
        echo "$modified_info" >> $file
        echo >> $file
    fi
done
