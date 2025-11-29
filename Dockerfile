FROM eclipse-temurin:17-jdk-jammy

RUN apt-get update && apt-get install -y \
    openjfx \
    libx11-6 libxext6 libxrender1 libxtst6 libxi6 libx11-xcb1 \
    libxcb1 libxcb-render0 libxcb-shape0 libxcb-xfixes0 libxrandr2 \
    libxinerama1 libxcomposite1 libxdamage1 libxfixes3 libxshmfence1 \
    libgtk-3-0 libasound2 libfreetype6 fontconfig \
    libjpeg-turbo8 libpng16-16 \
    libgl1-mesa-dri libglx-mesa0 libgl1-mesa-glx libegl1 libgles2 libgbm1 libdrm2 \
    mesa-utils x11-apps \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV JNI="/usr/lib/x86_64-linux-gnu/jni"
ENV MP="/usr/share/openjfx/lib"
ENV JAVA_TOOL_OPTIONS="" 
ENV PRISM_SW=0

CMD ["bash"]
