FROM ubuntu3

RUN apt-get update && apt-get install -y bind9 && apt-get install -y isc-dhcp-server && apt-get install -y vim

RUN echo "auto eth0" >> /etc/network/interfaces

RUN echo "iface eth0 inet static" >> /etc/network/interfaces

RUN echo "address 176.17.0.250" >> /etc/network/interfaces

RUN echo "netmask 255.255.0.0" >> /etc/network/interfaces

RUN ifdown eth0

RUN ifup eth0