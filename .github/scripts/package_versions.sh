path="$output_path/$version_name"
file="$output_path/$version_name/readme.txt"
recent="$output_path/recent.md"
echo >> $file
echo >> $file
echo "----------------------------------------" >> $file
echo "External Libraries:">> $file
echo >> $file
for package in $packages; do
  pkg_info=$(pacman -Qi "$package" 2>&1)
  info=$(echo "$pkg_info" | head -n 3)
  if [[ $info == "error"* ]]; then
    continue
  fi
  modified_info="${info/$package_prefix/}"
  modified_info="${modified_info/ (mingw-w64)/}"
  echo "$modified_info" >> $file
  echo >> $file
  build_date=$(echo "$pkg_info" | grep "Build Date" | cut -d: -f2- | xargs)
  if [[ -n "$build_date" ]]; then
    build_time=$(date -d "$build_date" +%s)
    current_time=$(date +%s)
    diff=$(( current_time - build_time ))
    days_old="14"
    build_date_threshold=$((86400 * $days_old))
    if [[ "$diff" -le "$build_date_threshold" ]]; then
      if [[ ! -f $recent ]]; then
        echo >> $recent
        echo "**Recently updated packages**  " >> $recent
        echo >> $recent
        echo "\`\`\`" >> $recent
      fi
      recently_updated=$(echo "$pkg_info" | head -n 2)
      echo "$recently_updated" >> $recent
      echo >> $recent
    fi
  fi
done
if [[ -f $recent ]]; then
  echo "\`\`\`" >> $recent
fi