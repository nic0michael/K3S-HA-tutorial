#!/bin/sh

#nano CreateDeploymentCommands4Ubuntu.sh
#chmod 775 CreateDeploymentCommands4Ubuntu.sh
#./CreateDeploymentCommands4Ubuntu.sh

LOGIN_USER1="nickm"
LOGIN_USER2="nickm"
LOGIN_USER3="nickm"
LOGIN_USER4="tonia"
LOGIN_USER5="nickm"

#You need to cahnge this token after the installation of the master node has been creaated
MASTER_TOKEN="K1026e692c09900990359e4959bea4c6b5bf943ddb7b2ca1d4bb7edfae7bff181da::server:c2f4a96a9a957e2c838c33c2f5707164"

MASTER_NODE_IP="10.154.2.88"
SECOND_MASTER_NODE_IP="10.154.2.93"
THIRD_MASTER_NODE_IP="10.154.2.97"
FIRST_WORKER_NODE_IP="10.154.2.113"
SECOND_WORKER_NODE_IP="10.154.2.4"


MASTER_NODE_NAME="buffalo.myk3s.com"
SECOND_MASTER_NODE_NAME="kudu.myk3s.com"
THIRD_MASTER_NODE_NAME="lion.myk3s.com"
FIRST_WORKER_NODE_NAME="tiger.myk3s.com"
SECOND_WORKER_NODE_NAME="rabbit.myk3s.com"

MASTER_NODE_URL="https://$MASTER_NODE_IP:6443"


echo "## K3S_HA_create_commands_for_Ubuntu.txt ##" 

echo "############################"
echo "# Create first master node #"
echo "############################"
echo "ssh $LOGIN_USER1@$MASTER_NODE_IP"
echo "sudo su -"
echo "/usr/local/bin/k3s-killall.sh"
echo "/usr/local/bin/k3s-agent-uninstall.sh"
echo "/usr/local/bin/k3s-uninstall.sh"
echo "\n"
echo "node_ip=\"$MASTER_NODE_IP\""
echo "node_name=\"$MASTER_NODE_NAME\""
echo "curl -sfL https://get.k3s.io | K3S_NODE_IP=\${node_ip} K3S_NODE_NAME=\${node_name} sh -s - server --cluster-init"
echo "\n"
echo "cat /var/lib/rancher/k3s/server/node-token"
echo "Update the token in this file"
echo "\n"

echo "#############################"
echo "# Create Second master node #"
echo "#############################"
echo "ssh $LOGIN_USER2@$SECOND_MASTER_NODE_IP"
echo "sudo su -"
echo "/usr/local/bin/k3s-killall.sh"
echo "/usr/local/bin/k3s-uninstall.sh"
echo "/usr/local/bin/k3s-agent-uninstall.sh"
echo "\n"
echo "k3s_token=\"$MASTER_TOKEN\""
echo "k3s_url=\"$MASTER_NODE_URL\""
echo "node_ip=\"$SECOND_MASTER_NODE_IP\""
echo "node_name=\"$SECOND_MASTER_NODE_NAME\""
echo "curl -sfL https://get.k3s.io | K3S_TOKEN=\${k3s_token} K3S_NODE_IP=\${node_ip} K3S_NODE_NAME=\${node_name} sh -s - server --server \${k3s_url}"
echo "\n"

echo "#############################"
echo "# Create Third master node #"
echo "#############################"
echo "ssh $LOGIN_USER3@$THIRD_MASTER_NODE_IP"
echo "sudo su -"
echo "/usr/local/bin/k3s-killall.sh"
echo "/usr/local/bin/k3s-uninstall.sh"
echo "/usr/local/bin/k3s-agent-uninstall.sh"
echo "\n"
echo "k3s_token=\"$MASTER_TOKEN\""
echo "k3s_url=\"$MASTER_NODE_URL\""
echo "node_ip=\"$THIRD_MASTER_NODE_IP\""
echo "node_name=\"$THIRD_MASTER_NODE_NAME\""
echo "curl -sfL https://get.k3s.io | K3S_TOKEN=\${k3s_token} K3S_NODE_IP=\${node_ip} K3S_NODE_NAME=\${node_name} sh -s - server --server \${k3s_url}"
echo "\n"

echo "############################"
echo "# Create First Worker Node #"
echo "############################"
echo "ssh $LOGIN_USER4@$FIRST_WORKER_NODE_IP"
echo "sudo su -"
echo "/usr/local/bin/k3s-killall.sh"
echo "/usr/local/bin/k3s-uninstall.sh"
echo "/usr/local/bin/k3s-agent-uninstall.sh"
echo "\n"
echo "k3s_token=\"$MASTER_TOKEN\""
echo "k3s_url=\"$MASTER_NODE_URL\""
echo "node_ip=\"$FIRST_WORKER_NODE_IP\""
echo "node_name=\"$FIRST_WORKER_NODE_NAME\""
echo "curl -sfL https://get.k3s.io | K3S_URL=\${k3s_url} K3S_TOKEN=\${k3s_token} K3S_NODE_IP=\${node_ip} K3S_NODE_NAME=\${node_name} sh -"
echo "\n"

echo "############################"
echo "# Create Second Worker Node #"
echo "############################"
echo "ssh $LOGIN_USER5@$SECOND_WORKER_NODE_IP"
echo "sudo su -"
echo "/usr/local/bin/k3s-killall.sh"
echo "/usr/local/bin/k3s-uninstall.sh"
echo "/usr/local/bin/k3s-agent-uninstall.sh"
echo "\n"
echo "k3s_token=\"$MASTER_TOKEN\""
echo "k3s_url=\"$MASTER_NODE_URL\""
echo "node_ip=\"$SECOND_WORKER_NODE_IP\""
echo "node_name=\"$SECOND_WORKER_NODE_NAME\""
echo "curl -sfL https://get.k3s.io | K3S_URL=\${k3s_url} K3S_TOKEN=\${k3s_token} K3S_NODE_IP=\${node_ip} K3S_NODE_NAME=\${node_name} sh -"
echo "############################"
echo "\n"
echo "ssh $LOGIN_USER1@$MASTER_NODE_IP"
echo "sudo su -"
echo "kubectl get nodes"


