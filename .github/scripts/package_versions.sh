path="$output_path/$version_name"
file="$path/readme.txt"
echo >> $file
echo >> $file
echo "----------------------------------------" >> $file
echo "External Libraries:">> $file
echo >> $file
for package in $packages; do
  pkg_info=$(pacman -Qi "$package" 2>&1 | head -n 3)
  if [[ $pkg_info != "error"* ]]; then
    modified_info="${pkg_info/$package_prefix-/}"
    modified_info="${modified_info/ (mingw-w64)/}"
    echo "$modified_info" >> $file
    echo >> $file
  fi
done
