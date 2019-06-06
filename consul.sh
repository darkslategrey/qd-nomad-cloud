consul_ip=127.0.0.1 
sed "/nameserver/anameserver $consul_ip" /etc/resolv.conf
