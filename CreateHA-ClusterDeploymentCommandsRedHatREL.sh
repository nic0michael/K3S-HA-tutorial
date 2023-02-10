
#!/bin/sh

## PERMANENTLY DISABLE FIREWALL ON MASTER and OTHER SERVERS ##
# Instructions can be found here
# https://linuxhint.com/disable-firewall-centos-8/

# IF YOU HAVE A PROBLEM CREATING THE OTHER NODES  AFTER CREATING THE MASTER NODE 
# When installing my K3s worker, k3s fails to start due to "level=error msg="failed to get CA c>"
# https://stackoverflow.com/questions/65872993/kubernetes-k3s-agent-cant-connect-to-master-ca-ssl-error

## 1. INSTALL NANO ##
echo "sudo yum install nano"

## 2. CREATE AND EDIT THIS FILE LOCALLY ##
# nano CreateDeploymentCommands4Ubuntu.sh

# You will need to update the details for your servers
# Now make changes for steps 3. to 5.

## MAKE THIS FILE EXECUTABLE ##
# chmod 775 CreateDeploymentCommands4Ubuntu.sh

## GENERATE THE KUBERNETES CLUSTER DEPLOYMENT CHECKLIST ##
# ./CreateDeploymentCommands4Ubuntu.sh > make-ubuntu-ha-cluster.txt

## 3. EDIT YOUR SERVER USER IDS ##
LOGIN_USER1="nickm"
LOGIN_USER2="nickm"
LOGIN_USER3="nickm"
LOGIN_USER4="nickm"
LOGIN_USER5="nickm"

#You need to change this token after the installation of the master node has been creaated
MASTER_TOKEN="K1026e692c09900990359e4959bea4c6b5bf943ddb7b2ca1d4bb7edfae7bff181da::server:c2f4a96a9a957e2c838c33c2f5707164"

## 4. EDIT YOUR SERVER IP ADDRESSES ##
MASTER_NODE_IP="10.154.2.88"
SECOND_MASTER_NODE_IP="10.154.2.188"
THIRD_MASTER_NODE_IP="10.154.2.93"
FIRST_WORKER_NODE_IP="10.154.2.188"
SECOND_WORKER_NODE_IP="10.154.2.93"

## 5. EDIT YOUR SERVER FQDNs (Fully Qualified Domain Names) ##
MASTER_NODE_NAME="buffalo.loseyourip.com"
SECOND_MASTER_NODE_NAME="tiger.loseyourip.com"
THIRD_MASTER_NODE_NAME="kudu.loseyourip.com"
FIRST_WORKER_NODE_NAME="tiger.loseyourip.com"
SECOND_WORKER_NODE_NAME="kudu.loseyourip.com"

MASTER_NODE_URL="https://$MASTER_NODE_IP:6443"


echo "## K3S_HA_Cluster_create_commands_for_Ubuntu.txt ##"

echo "\n"
echo "#################"
echo "# PREREQUISITES #"
echo "#################"
echo "Download Ubuntu Server 22.04"
echo "Install five VM instances in VirtualBox with these IP Addresses:"
echo "1. ${MASTER_NODE_IP} for the Master Node"
echo "2. ${SECOND_MASTER_NODE_IP} for the Second Master Node"
echo "3. ${THIRD_MASTER_NODE_IP} for the Third Master Node"
echo "4. ${FIRST_WORKER_NODE_IP} for the First Worker Node"
echo "5. ${SECOND_WORKER_NODE_IP} for the Second Worker Node"
echo "\n"
echo "Use DynuDNS (https://www.dynu.com/en-US/ControlPanel) create five DDNS services :"
echo "1. ${MASTER_NODE_NAME} pointing to IP Address: ${MASTER_NODE_IP} for the Master Node"
echo "2. ${SECOND_MASTER_NODE_NAME}  pointing to IP Address: ${SECOND_MASTER_NODE_IP} for the Second Master Node"
echo "3. ${THIRD_MASTER_NODE_NAME}  pointing to IP Address: ${THIRD_MASTER_NODE_IP} for the Third Master Node"
echo "4. ${FIRST_WORKER_NODE_NAME} pointing to IP Address: ${FIRST_WORKER_NODE_IP} for the First Worker Node"
echo "5. ${SECOND_WORKER_NODE_NAME} pointing to IP Address: ${SECOND_WORKER_NODE_IP} for the Second Worker Node"
echo "\n"
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
echo "#---------------------------------#"
echo "#- List Kubernetes Cluster Nodes -#"
echo "#---------------------------------#"
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml"
echo "kubectl get nodes"
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


echo "\n"
echo "#######################"
echo "# Destroy all servers #"
echo "#######################"
echo "ssh $LOGIN_USER1@$MASTER_NODE_IP"
echo "sudo su -"
echo "/usr/local/bin/k3s-killall.sh"
echo "/usr/local/bin/k3s-uninstall.sh"
echo "/usr/local/bin/k3s-agent-uninstall.sh"
echo "\n"
echo "ssh $LOGIN_USER2@$SECOND_MASTER_NODE_IP"
echo "sudo su -"
echo "/usr/local/bin/k3s-killall.sh"
echo "/usr/local/bin/k3s-uninstall.sh"
echo "/usr/local/bin/k3s-agent-uninstall.sh"
echo "\n"
echo "ssh $LOGIN_USER3@$THIRD_MASTER_NODE_IP"
echo "sudo su -"
echo "/usr/local/bin/k3s-killall.sh"
echo "/usr/local/bin/k3s-uninstall.sh"
echo "/usr/local/bin/k3s-agent-uninstall.sh"
echo "\n"
echo "ssh $LOGIN_USER4@$FIRST_WORKER_NODE_IP"
echo "sudo su -"
echo "/usr/local/bin/k3s-killall.sh"
echo "/usr/local/bin/k3s-uninstall.sh"
echo "/usr/local/bin/k3s-agent-uninstall.sh"
echo "\n"
echo "ssh $LOGIN_USER5@$SECOND_WORKER_NODE_IP"
echo "sudo su -"
echo "/usr/local/bin/k3s-killall.sh"
echo "/usr/local/bin/k3s-uninstall.sh"
echo "/usr/local/bin/k3s-agent-uninstall.sh"

