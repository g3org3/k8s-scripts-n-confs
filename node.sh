#!/bin/bash

#---------------------------->
MASTER_IP=167.99.39.220
TOKEN=9f56bf.63ab70c456366019
#---------------------------->


apt-get update

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update -y

apt-get install -y docker.io
apt-get install -y --allow-unauthenticated kubelet kubeadm kubectl kubernetes-cni

kubeadm join --token $TOKEN $MASTER_IP:6443 --discovery-token-unsafe-skip-ca-verification

# Install DigitalOcean monitoring agent
# curl -sSL https://agent.digitalocean.com/install.sh | sh
