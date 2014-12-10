FROM ubuntu:latest

# update and install required packages
RUN apt-get update && apt-get install -y isc-dhcp-server && apt-get install -y bind9 && apt-get install -y nano

# configure ip
ADD ./etc/network/interfaces /etc/network/interfaces

RUN ifdown docker0
RUN ifup docker0
