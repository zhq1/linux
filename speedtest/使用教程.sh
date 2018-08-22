wget -O speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py --no-check-certificate
chmod +x speedtest-cli
./speedtest-cli
mv speedtest.py /usr/local/bin/speedtest
chown root:root /usr/local/bin/speedtest
speedtest-cli --list|more
speedtest-cli
speedtest