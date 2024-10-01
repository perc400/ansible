#!/bin/bash

set -e

ufw allow 3100/tcp

cd /usr/src/
git clone https://github.com/grafana/loki
cd loki/

go build ./cmd/loki

mv loki /usr/local/bin/
mkdir /etc/loki

mv cmd/loki/loki-local-config.yaml /etc/loki/
sed -i 's/\/tmp\/wal/\/opt\/loki\/wal/g' /etc/loki/loki-local-config.yaml
sed -i 's/\/tmp\/loki/\/opt\/loki/g' /etc/loki/loki-local-config.yaml

mkdir /opt/loki

useradd -M --shell /bin/false loki
chown -R loki:loki /usr/local/bin/loki
chown -R loki:loki /etc/loki
chown -R loki:loki /opt/loki

touch /etc/systemd/system/loki.service
cat > /etc/systemd/system/loki.service << EOF
[Unit]
Description=Grafana Loki Service
After=network.target

[Service]
User=loki
Group=loki
Type=simple
ExecStart=/usr/local/bin/loki -config.file=/etc/loki/loki-local-config.yaml
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
