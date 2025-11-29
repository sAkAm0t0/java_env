find ./report -type d -name "632*" | while read -r dir; do
  cp "$1" "$dir/$2"
done
