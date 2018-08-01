#!/bin/bash

# ---------------------------> 
MASTER_IP=xxxxx
TOKEN=9f56bf.63ab70c456366019
NETWORK=10.244.0.0/16
#---------------------------->

bigecho() {
  echo "> $1" >> /root/script.log
}

bigecho "update and install jq"
apt-get update -y
apt-get install -y jq

RAW_IP=`curl -Ss ipinfo.io | jq '.ip'`
MASTER_IP=`sed -e 's/^"//' -e 's/"$//' <<<"$RAW_IP"`

bigecho "add google cloud key to sourcelist"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

bigecho "update again"
apt-get update -y

bigecho "install docker"
apt-get install -y docker.io

bigecho "install K8 stuff"
apt-get install -y --allow-unauthenticated kubelet kubeadm kubectl kubernetes-cni

bigecho "SETUP K8"
kubeadm init --pod-network-cidr=$NETWORK  --apiserver-advertise-address $MASTER_IP --token $TOKEN

export HOME=/root
cp /etc/kubernetes/admin.conf $HOME/
chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf

bigecho "SETUP Dashboard, flannel"
# kubectl create -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml --namespace=kube-system
kubectl create -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml --namespace=kube-system
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml --namespace=kube-system

# Install DigitalOcean monitoring agent
# curl -sSL https://agent.digitalocean.com/install.sh | sh

bigecho $MASTER_IP
bigecho "DONE"
