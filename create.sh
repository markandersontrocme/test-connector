#!/bin/bash

total=500
dirs=5
per_dir=$(( total / dirs ))

for d in $(seq 1 $dirs); do
  dirname="networks-$d"
  mkdir -p "$dirname"
  
  start=$(( (d - 1) * per_dir + 1 ))
  end=$(( d * per_dir ))

  for i in $(seq $start $end); do
    cat <<EOF > "$dirname/network$i.yaml"
apiVersion: platform.acme.co/v1alpha1
kind: Network
metadata:
  name: network$i
  namespace: test
spec:
  parameters:
    autoCreateSubnetworks: false
    routingMode: "GLOBAL"
EOF
  done
done

echo "Generated $total Network manifests split across $dirs directories."

