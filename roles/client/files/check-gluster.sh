#!/bin/sh
#
# Verifies Gluster's peering status

peers=`gluster peer status | grep "Number of Peers"| awk -F':' '{print $2}'`
connected_peers=`gluster peer status | grep "State: Peer in Cluster (Connected)"| wc -l`


if [ $peers -ne $connected_peers ]
	then "Critical: there are only $connected_peers out of $peers!!"
	exit 2
else
  echo "All gluster peers are connected"
    exit 0
fi

