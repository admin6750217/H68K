#!/bin/bash

mkdir -p files/etc/sysctl.d

cat > files/etc/sysctl.d/99-conntrack.conf <<'EOF'
net.netfilter.nf_conntrack_max=655000
EOF
