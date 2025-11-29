java -Djava.library.path="$JNI" \
  -Dprism.order=es2,sw -Djavafx.platform=x11 -Dprism.verbose=true \
  --module-path "$MP" --add-modules=javafx.controls,javafx.fxml \
  "$@"
