NetworkDocker
=============

#1 - Network Topology
The network topology is composed of two DNS servers, a dhcp server, and a ssh server, running on three virtual machine. Configuration files are located in subdirectories of /configurationFiles corresponding do their absolutes path in the file system.

#2 - Client And Server Programs in Perl

##### Introduction
Those programs are meant to monitor the network between the client and the server, by evaluating RTT (Round Trip Time), effective throughput, and the percentage of errors for packets transmission.

##### How does it work ?
The client sends packets of increasing sizes (1Kb, 2Kb, 4Kb, ...) to the server. For each size, it sends 100 packets, and makes statistics based on the server response.

##### Usage
- Go to folder /clientServerProgram
- Run server first in terminal : "perl server.pl"
- Run client in terminal : "perl client.pl"

By default, server address is 127.0.0.1, and default port is 3711. If you wish to change them, you may run "perl client.pl myServerAddress myServerPort"