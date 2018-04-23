#!/bin/bash
nohup openvpn  --config /etc/openvpn/client/client.ovpn >/dev/null 2>&1 &
