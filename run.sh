docker run --rm -it \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "$PWD/report:/app/report" \
  -v "$PWD/tools:/app/report/tools" \
  javafx17
