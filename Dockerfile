FROM ubuntu:20.04

# User can't set timezones and things during build
ENV DEBIAN_FRONTEND=noninteractive

# Install apt packages
RUN apt-get update -y
RUN apt-get install -y \
    build-essential \
    git \
    paraview \
    vim \
    flex \
    mpich \
    libopenmpi-dev \
    zlib1g-dev \
    scotch \
    libscotch-dev \
    ptscotch \
    libptscotch-dev \
    paraview

# Alternate can be specified with --build-arg flag
ARG OF_VER=OpenFOAM-8

# Dump in OpenFOAM to /opt
WORKDIR /opt
RUN git clone https://github.com/OpenFOAM/${OF_VER}.git
WORKDIR /opt/${OF_VER}

# Set this, because OpenFOAM docs mention
ENV WM_PROJECT_DIR=/opt/${OF_VER}

# Set env and build OpenFOAM
RUN /bin/bash -c "source $WM_PROJECT_DIR/etc/bashrc ; ./Allwmake -j"
