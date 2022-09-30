# K3S-HA Create Commands tutorial
This is a simple solution that gets you started quickly and easily with K3S High Availability clusters

This project provides you with a choice of two shell scripts that generates a text file with all the commands you need to run on the First 3 Master servers as well as on your worker node servers

Edit one of two shell scripts provided you want to use with the parameters your your servers and use it to generate all the commands you need to run on your servers in a single text file


## Two create scripts provided

CreateDeploymentCommands.sh

CreateDeploymentCommands4Ubuntu.sh (this script has been tested with Ubuntu and Mint Linux)


## How to use the shell scripts
You need to choose which of the above scripts you want to use. 

### 1) Edit this shell script with your server and user details.
nano CreateDeploymentCommands4Ubuntu.sh

### 2) Make the shell script executable
chmod 775 CreateDeploymentCommands4Ubuntu.sh

### 3) When you run the script pass the output to a text file
./CreateDeploymentCommands4Ubuntu.sh > ubuntuServerDeploymentList.txt

### 4) You now can use the file to create all your Node Servers
ubuntuServerDeploymentList.txt

### 5) After creating the First Master Server Node edit the shell script and update the MASTER_TOKEN  
[run on the server to get token] cat /var/lib/rancher/k3s/server/node-token

nano CreateDeploymentCommands4Ubuntu.sh

./CreateDeploymentCommands4Ubuntu.sh > ubuntuServerDeploymentList.txt
