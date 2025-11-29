#!/usr/bin/env bash
set -euo pipefail

# 使い方チェック
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <java command...>"
  echo "  e.g.: $0 java -jar MyApp.jar"
  exit 2
fi

JAVA_CMD=("$@") # 引数のJava実行コマンド
TARGET="data.txt"

# 元のdata.txtを退避
ts=$(date +%Y%m%d-%H%M%S)
BACKUP="${TARGET}.bak_${ts}"
HAD_ORIG=false
if [[ -f "$TARGET" ]]; then
  mv -f "$TARGET" "$BACKUP"
  HAD_ORIG=true
fi

restore_original() {
  # 終了時に元のdata.txtを復元
  if $HAD_ORIG && [[ -f "$BACKUP" ]]; then
    mv -f "$BACKUP" "$TARGET"
    echo "Restored original $TARGET."
  fi
}
trap restore_original EXIT

# data1.txt〜data4.txtを順に処理
for i in {1..4}; do
  SRC="data${i}.txt"
  if [[ ! -f "$SRC" ]]; then
    echo "Warning: $SRC not found. Skipped."
    continue
  fi

  # data.txt にリネーム
  mv -f "$SRC" "$TARGET"
  echo "[${i}/4] Renamed $SRC -> $TARGET"

  # Javaコマンド実行
  echo "Running: ${JAVA_CMD[*]}"
  if "${JAVA_CMD[@]}"; then
    echo "OK: ${JAVA_CMD[*]}"
  else
    echo "ERROR: command failed for $SRC" >&2
    # 失敗しても元のファイル名を戻す
    mv -f "$TARGET" "$SRC"
    exit 1
  fi

  # 元の名前に戻す
  mv -f "$TARGET" "$SRC"
  echo "Restored: $SRC"
done

# 正常終了時に元のdata.txtを戻す
trap - EXIT
if $HAD_ORIG && [[ -f "$BACKUP" ]]; then
  mv -f "$BACKUP" "$TARGET"
  echo "Restored original $TARGET."
fi

echo "Done."
