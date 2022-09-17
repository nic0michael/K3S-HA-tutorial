# K3S-HA Create Commands tutorial

## Two create scripts provided

CreateDeploymentCommands.sh

CreateDeploymentCommands4Ubuntu.sh (this script has been tested with Ubuntu and Mint Linux)


## How to use the shell scripts
You need to chose which of the above scripts you want to use. 

### Edit this shell script with your server and user details.
nano CreateDeploymentCommands4Ubuntu.sh

### Make the shell script executable
chmod 775 CreateDeploymentCommands4Ubuntu.sh

### When you run the script pass the output to a text file
./CreateDeploymentCommands4Ubuntu.sh > ubuntuServerDeploymentList.txt

### After creating the First Master Server Node edit the shell script and update the MASTER_TOKEN  
[run on the server to get token] cat /var/lib/rancher/k3s/server/node-token

nano CreateDeploymentCommands4Ubuntu.sh

./CreateDeploymentCommands4Ubuntu.sh > ubuntuServerDeploymentList.txt
