;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA    ubuntu1.julien.com. root.ubuntu1.julien.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ubuntu1.julien.com.
ubuntu1	IN      A       192.168.109.130
