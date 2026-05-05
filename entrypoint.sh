#!/bin/bash
set -e

# REDIRECT is local so SO_ORIGINAL_DST works; filter to uid 0 (claude) to avoid
# looping mitmproxy's own outbound connections back into the proxy
iptables -t nat -A OUTPUT -p tcp ! -d 127.0.0.0/8 -m owner --uid-owner 0 -j REDIRECT --to-port 8080

cp /home/ubuntu/.mitmproxy/mitmproxy-ca-cert.pem \
   /usr/local/share/ca-certificates/mitmproxy.crt

update-ca-certificates

export HOME="/home/ubuntu"
exec /home/ubuntu/.local/bin/claude "$@"
# exec /bin/bash