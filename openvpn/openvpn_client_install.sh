yum install -y openvpn
vi /etc/openvpn/client/vpn.ovpn
#配置
client
dev tap
proto tcp
remote wtj.1nth.com 10094
#ca /etc/openvpn/conf/ca.crt
keepalive 10 120
cipher AES-256-CBC
auth SHA1
auth-user-pass /etc/openvpn/client/pass.txt
verb 5
#取消默认网关走VPN
#redirect-gateway def1
#route -p add 10.10.66.0 mask 255.255.255.0 10.10.6.1
#route 192.168.1.0 255.255.255.0
#script-security 3
#route-method exe
#route-delay 2
#route 10.10.66.0 255.255.255.0 10.10.6.1
#;script-security 2 system
#push "route 10.10.66.0 255.255.255.0 10.10.6.1"
<ca>
-----BEGIN CERTIFICATE-----
MIIDbzCCAtigAwIBAgIJAKgg0d8F8/jBMA0GCSqGSIb3DQEBBAUAMIGCMQswCQYD
VQQGEwJUVzELMAkGA1UECBMCVFcxDzANBgNVBAcTBlRhaXdhbjENMAsGA1UEChME
b3ZwbjEQMA4GA1UECxMHeWF3cHluZzERMA8GA1UEAxMIcm91dGVyb3MxITAfBgkq
hkiG9w0BCQEWEm92cG4uZ2Z3QGdtYWlsLmNvbTAeFw0xMjAzMTExNDA5MjVaFw0y
MjAzMDkxNDA5MjVaMIGCMQswCQYDVQQGEwJUVzELMAkGA1UECBMCVFcxDzANBgNV
BAcTBlRhaXdhbjENMAsGA1UEChMEb3ZwbjEQMA4GA1UECxMHeWF3cHluZzERMA8G
A1UEAxMIcm91dGVyb3MxITAfBgkqhkiG9w0BCQEWEm92cG4uZ2Z3QGdtYWlsLmNv
bTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAuZfqaFpComUCM58mFWD6Eon8
sFvuYUJ8gY4KtDjfUA63Z+g8vwfHXEu8mqybW2PgIRL4krWLwj66FGMuq6G/mM+2
Jre1uJygCtcm5kCefMkv+I4YlzG/k7ErY7s1VdwQN9VKFwkvFTIqyhk3W0rtlGiP
dlihWwkNqHfukT8kTzMCAwEAAaOB6jCB5zAdBgNVHQ4EFgQUkZdX6x7hULpjiTsA
6G0ZaMiayNIwgbcGA1UdIwSBrzCBrIAUkZdX6x7hULpjiTsA6G0ZaMiayNKhgYik
gYUwgYIxCzAJBgNVBAYTAlRXMQswCQYDVQQIEwJUVzEPMA0GA1UEBxMGVGFpd2Fu
MQ0wCwYDVQQKEwRvdnBuMRAwDgYDVQQLEwd5YXdweW5nMREwDwYDVQQDEwhyb3V0
ZXJvczEhMB8GCSqGSIb3DQEJARYSb3Zwbi5nZndAZ21haWwuY29tggkAqCDR3wXz
+MEwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQQFAAOBgQAsHyvEOlpjEXZNQGWX
fOQcC68JrGE691z2qKrnjMfLohMrynBhSs2gGxM5W7UeJaOwLXWBd+hkoOPcBJkN
8P/hOdBZ61W7ZNuqQLzDJvx5Z2vSrp5I7Rdti888MxAOSlUaU6G0Bdcjd13+v+Ab
XL6opCcNGB2q8+eualOmQlNW8g==
-----END CERTIFICATE-----
</ca>
#up client.ovpn_up.bat


vi etc/openvpn/client/pass.txt
帐号
密码

#启动命令
openvpn --daemon --config /etc/openvpn/client/vpn.ovpn
#或者
nohup openvpn  --Cnfig /etc/openvpn/client/client.ovpn >/dev/null 2>&1 &