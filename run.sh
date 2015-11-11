#!/bin/bash
set -eo pipefail

SECRET=${@:-`btsync --generate-secret`}

echo "Starting btsync with secret: $SECRET"

rm -f /btsync/btsync.pid

[ ! -f /btsync/btsync.conf ] && cat > /btsync/btsync.conf <<EOF
{
  "device_name": "Sync Server",
  "listening_port": 55555,
  "storage_path": "/btsync/.sync",
  "pid_file": "/btsync/btsync.pid",
  "check_for_updates": false,
  "use_upnp": false,
  "download_limit": 0,
  "upload_limit": 0,
  "shared_folders": [{
    "secret": "$SECRET",
    "dir": "/data",
    "use_relay_server": true,
    "use_tracker": true,
    "use_dht": false,
    "search_lan": true,
    "use_sync_trash": false
  }]
}
EOF

btsync --config /btsync/btsync.conf --nodaemon
