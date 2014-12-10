#!/usr/bin/perl -w

use IO::Socket::INET;
use Time::HiRes;

print "\nUsage: perl client.pl [serverAddress=\"127.0.0.1\"] [serverPort=3711]\n";
print "\nThis client will connect to the server with UDP protocol, ";
print "and send packets from 1KB to 32KB, until an error occurs. ";
print "It sends 100 packets per size, and computes average RTT, ";
print "effective throughput, and quantity of lost packages.\n";

$numArgs = $#ARGV + 1;

my $serverAddress = "127.0.0.1";
my $serverPort = "3711";
if ($numArgs >= 1) {
    $serverAddress = $ARGV[0];
} elsif ($numArgs >= 2) {
    $serverAddress = $ARGV[0];
    $serverPort = $ARGV[1];
}
print "\nserver address is $serverAddress\n";
print "server port is $serverPort\n";

my $client = IO::Socket::INET->new( PeerPort=> $serverPort, PeerAddr=> $serverAddress, Proto=> 'udp')
or die "Could not open socket! Please check address and port, and make sure to start server.pl before client.pl\n";
my $data;
my $start = 0;
my $end = 0;
my $elapsedTime = 0;
my $s = "0";
my $nopr = 0; #number of packet received
my $tmp = '';

#for printing on a graph
my @RTT = ();
my @thrghpt = ();
my @sendSize = ();
my @lostPacket = ();


for (my $i = 0; $i < 10; $i++) {$s .= $s;} #$s = 0000000.... 1024 times : 1kB reference

print "\n Size\t| average RTT\t| eff thrghpt\t| # lost \n";

for (my $packetSize = 1; $packetSize < 33; $packetSize *= 2) { #loop from 1kB to 32kB
    $start = Time::HiRes::gettimeofday();#start timer
    $nopr = 0;
    for (my $packetNumber = 0; $packetNumber < 100; $packetNumber++) { #loop for 100 packets
        #check if packet arrives with eval block
        $client->send($s) or die "Error while sending : $!\n";
        $tmp = $client->recv($data, 32768) or die "Error while receiving : $! ! Please check address and port, and make sure to start server.pl before client.pl\n";
        $nopr++ if(defined($tmp)); #check if packet is lost
        push(@lostPacket, length($s) - length($data));
    }
    $elapsedTime = Time::HiRes::gettimeofday()- $start; #stop timer and get elapsedTime
    push(@sendSize, length($s));
    push(@RTT, $elapsedTime / $nopr);
    push(@thrghpt, length($s) / ($elapsedTime/100));
    printf("%dkB \t| %.3e\t| %.3e\t| %d\n",$packetSize, $elapsedTime / $nopr, length($s) / ($elapsedTime/100), 100 - $nopr);
    $s .= $s; #incrementing size of $s by two
}

print "Shutting down server ...\n";
$client->send("END_OF_TEST") or die "Error while sending : $!\n";

print "Shutting down client ...\n";
close $client;

print '@RTT=(';
for (my $i = 0; $i < @RTT; $i++) {
    print " " . $RTT[$i] . ",";
}
print ")\n" . '@thrghpt =(';
for (my $i = 0; $i < @thrghpt; $i++) {
    print " " . $thrghpt[$i] . ",";
}
print ")\n" . '@sendSize =(';
for (my $i = 0; $i < @sendSize; $i++) {
    print " " . $sendSize[$i] . ",";
}
print ")";
