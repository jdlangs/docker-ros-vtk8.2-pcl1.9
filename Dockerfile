FROM jdlangs/ros-vtk8.2:latest
LABEL maintainer="Josh Langsfeld <jdlangs@gmail.com>"

RUN apt-get update -qq && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
      make cmake build-essential git \
      libgl1-mesa-dev \
      libglew-dev \
      libxt-dev \
      libeigen3-dev \
      libflann-dev \
      libusb-1.0-0-dev \
      libpcap-dev \
      libboost-all-dev \
      libproj-dev \
      && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN \
    git clone --branch "pcl-1.9.1" --depth 1 https://github.com/PointCloudLibrary/pcl.git pcl-snapshot && \
    mkdir pcl-build && cd pcl-build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DWITH_ENSENSO=OFF -DWITH_OPENNI=OFF -DWITH_OPENNI2=OFF -DPCL_ENABLE_SSE=OFF ../pcl-snapshot && \
    make -j 4 && make install && \
    make clean && cd /tmp && rm -rf pcl-build && rm -rf pcl-snapshot && \
    ldconfig

WORKDIR /
