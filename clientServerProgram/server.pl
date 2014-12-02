#!/usr/bin/perl -w

use IO::Socket::INET;

my $server = IO::Socket::INET->new(LocalPort => 3711, Proto => 'udp')
or die "Could not open socket!\n";
my $data = "";
my $cpt = 2;


my ($peer_address,$peer_port);


while($cpt > 0)
{
    $server->recv($data,32768);
    $peer_address = $server->peerhost();
    $peer_port = $server->peerport();
    print "($peer_address , $peer_port)\n";
    $server->send($data);

    $cpt -= 1 if($data =~ "END_OF_TEST")
}

print "Shutting down server ...\n";
close $server;
