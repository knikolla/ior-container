FROM ubuntu:24.04

RUN apt update &&  \
    apt install -y mpich wget build-essential && \
    wget https://github.com/hpc/ior/releases/download/4.0.0/ior-4.0.0.tar.gz && \
    tar -xzvf ior-4.0.0.tar.gz && \
    cd ior-4.0.0 && \
    ./configure && \
    make && \
    make install
