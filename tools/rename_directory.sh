find ./report -type d -name "632*" | while read -r dir; do
	newdir=$(basename "$dir" | cut -c1-7)
	parent=$(dirname "$dir")

	mv "$dir" "$parent/$newdir"
done
