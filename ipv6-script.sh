#!/bin/bash
do_start()
{
echo "adding native ipv6 to eth0"
#########################################################################
# kalo mau nambahin ip di sini ya
#########################################################################
/sbin/ip -6 addr add 2a04:dd00:17:9::2/48 dev eth0
/sbin/ip -6 addr add 2a04:dd00:17:9::3/48 dev eth0
/sbin/ip -6 addr add 2a04:dd00:17:9::4/48 dev eth0
/sbin/ip -6 addr add 2a04:dd00:17:9::5/48 dev eth0
/sbin/ip -6 addr add 2a04:dd00:17:9::6/48 dev eth0
/sbin/ip -6 addr add 2a04:dd00:17:9::7/48 dev eth0
/sbin/ip -6 addr add 2a04:dd00:17:9::8/48 dev eth0
/sbin/ip -6 addr add 2a04:dd00:17:9::9/48 dev eth0
/sbin/ip -6 addr add 2a04:dd00:17:9::10/48 dev eth0
/sbin/ip -6 addr add 2a04:dd00:17:9::11/48 dev eth0
/sbin/ip -6 addr add 2a04:dd00:17:9::12/48 dev eth0
/sbin/ip -6 addr add 2a04:dd00:17:9:14:91:111:1/48 dev eth0
/sbin/ip -6 addr add 2a04:dd00:17:9::51:1790/48 dev eth0
#########################################################################
# WARNING! bagian ini sampe pager bawah lagi bintang 3 jgn di rubah yak!
#########################################################################
/sbin/ip route flush cache
/sbin/ip -6 route flush cache
# add ip he net
echo "ipv6 he.net added at sit1."
/sbin/ip tun add sit1 local 185.82.202.36 remote 216.66.84.46 ttl 255
/sbin/ifconfig sit1 up
/sbin/ip -6 addr add 2001:470:1f14:9aa::2/64 dev sit1
/sbin/ip -6 addr add 2001:470:1f14:9aa::69/64 dev sit1
/sbin/ip -6 addr add 2001:470:1f14:9aa::96/64 dev sit1
/sbin/ip -6 addr add 2001:470:1f14:9aa::18/64 dev sit1
# add routing table for native ipv6 from provider also from he.net
/sbin/ip -6 route add default via 2a04:dd00:17::1 table 1
/sbin/ip -6 rule add from 2a04:dd00:17::/48 table 1
/sbin/ip -6 route add default via 2001:470:1f14:9aa::1 table 2
/sbin/ip -6 rule add from 2001:470:1f14:9aa::/64 table 2
#########################################################################
# bintang bintang bintang * * * 
#########################################################################
}

do_stop()
{
echo "removing native ipv6 from eth0"
#########################################################################
# abis nambahin ip jgn lupa tambahin delete ip nya di sini
#########################################################################
/sbin/ip -6 addr del 2a04:dd00:17:9::2/48 dev eth0
/sbin/ip -6 addr del 2a04:dd00:17:9::3/48 dev eth0
/sbin/ip -6 addr del 2a04:dd00:17:9::4/48 dev eth0
/sbin/ip -6 addr del 2a04:dd00:17:9::5/48 dev eth0
/sbin/ip -6 addr del 2a04:dd00:17:9::6/48 dev eth0
/sbin/ip -6 addr del 2a04:dd00:17:9::7/48 dev eth0
/sbin/ip -6 addr del 2a04:dd00:17:9::8/48 dev eth0
/sbin/ip -6 addr del 2a04:dd00:17:9::9/48 dev eth0
/sbin/ip -6 addr del 2a04:dd00:17:9::10/48 dev eth0
/sbin/ip -6 addr del 2a04:dd00:17:9::11/48 dev eth0
/sbin/ip -6 addr del 2a04:dd00:17:9::12/48 dev eth0
/sbin/ip -6 addr del 2a04:dd00:17:9:14:91:111:1/48 dev eth0
/sbin/ip -6 addr del 2a04:dd00:17:9::51:1790/48 dev eth0
#########################################################################
# WARNING! bagian bawah sini sampe bintang 2 jangan di utek-utek ya!
#########################################################################
# remove sit1 and flush cache also delete the routing table
echo "removing sit1 and flushing the routing cache"
/sbin/ip tun del sit1
/sbin/ip route flush cache
/sbin/ip -6 route flush cache
/sbin/ip -6 route del default via 2a04:dd00:17::1 table 1
/sbin/ip -6 rule del from 2a04:dd00:17::/48 table 1
/sbin/ip -6 route del default via 2001:470:1f14:9aa::1 table 2
/sbin/ip -6 rule del from 2001:470:1f14:9aa::/64 table 2
#########################################################################
# bintang bintang * *
#########################################################################
}

case "$1" in
	start)
	   do_start
	   echo "ipv6 native added at eth0"
	  ;;
	stop)
	   do_stop
	   echo "ipv6 native added at eth0"
	  ;;
	restart)
	   do_stop
           do_start
	  echo "ipv6 native restarted at eth0"
	  ;;
        *)
           echo $"Usage: $0 {start|stop|restart}"
	  ;;
esac

