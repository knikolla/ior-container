FROM ubuntu:24.04

RUN apt update &&  \
    apt install -y mpich ssh wget build-essential && \
    wget https://github.com/hpc/ior/releases/download/4.0.0/ior-4.0.0.tar.gz && \
    tar -xzvf ior-4.0.0.tar.gz && \
    cd ior-4.0.0 && \
    ./configure && \
    make && \
    make install

# mpi-operator mounts the .ssh folder from a Secret. For that to work, we need
# to disable UserKnownHostsFile to avoid write permissions.
# Disabling StrictModes avoids directory and files read permission checks.
RUN echo "    UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config && \
    sed -i 's/#\(StrictModes \).*/\1no/g' /etc/ssh/sshd_config


RUN mkdir /home/mpiuser && \
    chown -R 1001:1001 /home/mpiuser

USER 1001
WORKDIR /home/mpiuser
# COPY entrypoint.sh /

# ENTRYPOINT [ "/entrypoint.sh" ]
