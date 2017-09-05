#!/bin/bash

set -u -o pipefail

function die {
    >&2 echo -e "$1"
    exit 1
}

function main {
    local node_version=6.9.4
    local node_dir="node-v${node_version}-linux-x64"
    local node_installer="$node_dir.tar.gz"
    local node_url="https://nodejs.org/download/release/v${node_version}/$node_installer"
    test -d "/opt/$node_dir" && die "ERROR: /opt/$node_dir already exists"
    echo "installing node $node_version"
    wget -q -O "/tmp/$node_installer" "$node_url"
    if [ $? -ne 0 -o ! -s "/tmp/$node_installer" ]; then
        rm "/tmp/$node_installer"
        die "ERROR: failed to download $node_url"
    fi
    tar -zxf "/tmp/$node_installer" -C /opt || die "ERROR: failed to unpack nodejs in /opt"
    ln -s "/opt/$node_dir" /opt/node
}

main
