#!/bin/bash
openvpn --daemon --config /etc/openvpn/conf/vpn.conf > /var/log/openvpn_client.log
