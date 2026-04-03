#!/bin/bash
set -euo pipefail

echo "==> Installing Go 1.22..."
wget -q https://go.dev/dl/go1.22.5.linux-amd64.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
rm go1.22.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
go version

echo "==> Building gateway-plugin..."
make build-gateway-plugins-nozmq

echo "==> Installing Envoy 1.37.1..."
ENVOY_VERSION=1.37.1
wget -q -O /usr/local/bin/envoy "https://github.com/envoyproxy/envoy/releases/download/v${ENVOY_VERSION}/envoy-${ENVOY_VERSION}-linux-x86_64"
chmod +x /usr/local/bin/envoy
envoy --version

echo "==> Done! Gateway plugin built at bin/gateway-plugins, Envoy installed at /usr/local/bin/envoy"
