FROM ubuntu:20.04

RUN apt-get update -y ; \
apt-get install -y \
    build-essential \
    git \
    paraview \
    vim \
    flex \
    mpich \
    libopenmpi-dev \
    zlib1g-dev

ARG OF_VER=OpenFOAM-8

WORKDIR /opt
RUN git clone https://github.com/OpenFOAM/${OF_VER}.git
WORKDIR /opt/${OF_VER}

ENV WM_PROJECT_DIR=/opt/${OF_VER}

RUN /bin/bash -c "source $WM_PROJECT_DIR/etc/bashrc ; ./Allwmake -j"
