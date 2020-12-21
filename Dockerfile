FROM debian:buster

# Install essential binaries
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git build-essential python3-dev gdb htop

# Clone, configure and build ns3
RUN git clone https://gitlab.com/nsnam/ns-3-dev.git
RUN cd ns-3-dev && ./waf configure --enable-examples --enable-tests --enable-mpi && ./waf build
RUN cd ns-3-dev && ./waf --run scratch/scratch-simulator

WORKDIR /ns-3-dev
ENTRYPOINT [ "/bin/bash" ]