#!/bin/bash

set -e

wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz

tar -C /usr/local -xzf go*.tar.gz

echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile

export PATH=$PATH:/usr/local/go/bin
