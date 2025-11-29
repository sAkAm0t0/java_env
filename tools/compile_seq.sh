/!/usr/bin/env bash
set -u -o pipefail

echo "Scanning *.java in: $(pwd)"

# 直下の .java を配列に収集（順序は任意）
mapfile -d '' JAVA_FILES < <(find . -maxdepth 1 -type f -name '*.java' -print0)

count=${#JAVA_FILES[@]}
if ((count == 0)); then
  echo "No .java files in current directory."
  exit 0
fi

ok=0
ng=0
failed=()

for f in "${JAVA_FILES[@]}"; do
  bn=${f##*/}
  echo "[$((ok + ng + 1))] Compiling: $bn"
  # ループのstdinを消費しないようにする必要はこの方式では不要
  if ../tools/javac.sh "$f"; then
    ((ok++))
  else
    ((ng++))
    failed+=("$f")
    echo "  -> Failed: $f" >&2
  fi
done

echo
echo "Summary: ${ok} succeeded, ${ng} failed (total ${count})."
if ((ng > 0)); then
  printf 'Failed files:\n'
  printf '  %s\n' "${failed[@]}"
  exit 1
fi
exit 0
