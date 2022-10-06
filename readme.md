# K3S-HA Create Commands Generator Tutorial
This is a simple solution that gets you started quickly and easily with K3S High Availability clusters

This project provides you with a choice of two shell scripts that generates a text file with all the commands you need to run on the First 3 Master servers as well as on your worker node servers

Edit one of two shell scripts provided you want to use with the parameters your your servers and use it to generate all the commands you need to run on your servers in a single text file

## Setup Required
* You need 4/5 Linux Servers with Ubuntu 22.04 server installed
* I used two PC's with Mint Linux Workstation and installed Virtual Box on each and added one Ubuntu 22.04 server VM
* You need to setup Static IP addresses for each server
* You need DNS entries for your servers if you don't have facilities to do that DynuDNS will give you 4 DNS entries for free
* You need to setup a free account with DynuDNS  :  https://www.dynu.com/en-US/ControlPanel/Login
* With DynuDNS you create 4 free Dynamic DNS entries for your servers:  https://www.dynu.com/en-US/ControlPanel/DDNS
* Enter the Host name you want "elephant" (I used animals) and Choose a suitable Toplevel name "kozow.com"

## Two create scripts provided

CreateDeploymentCommands4Ubuntu.sh (this script has been tested with both Ubuntu and Mint Linux) get it here:

https://github.com/nic0michael/K3S-HA-tutorial/blob/master/CreateHA-ClusterDeploymentCommands4Ubuntu.sh

## How to use the shell scripts
You need to choose which of the above scripts you want to use.

### 1) Edit this shell script with your server and user details.
```
nano CreateDeploymentCommands4Ubuntu.sh
```

### 2) Make the shell script executable
```
chmod 775 CreateDeploymentCommands4Ubuntu.sh
```

### 3) When you run the script pass the output to a text file
```
./CreateDeploymentCommands4Ubuntu.sh > ubuntuServerDeploymentList.txt
```

### 4) You now can use the file to create all your Node Servers
ubuntuServerDeploymentList.txt

Now run this command to display this file
```
cat ubuntuServerDeploymentList.txt
```

### 5) After creating the First Master Server Node get the MASTER_TOKEN  
run on the server to get token
```
cat /var/lib/rancher/k3s/server/node-token
```
### 6) Now Edit the script and update the Master Token in it
```
nano CreateDeploymentCommands4Ubuntu.sh
```
### 7) Now run the script again
```
./CreateDeploymentCommands4Ubuntu.sh > ubuntuServerDeploymentList.txt
```
### 8) You now can use the file to create all your Node Servers
ubuntuServerDeploymentList.txt


Now run this command to display this file
```
cat ubuntuServerDeploymentList.txt
```
