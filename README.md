# Kubernetes and Vagrant Single-Node Setup

##Forked from https://github.com/coreos/coreos-kubernetes

####**Prerequisites:** 
> Install latest version >= 1.6.2 of Vagrant from [here](https://www.vagrantup.com/downloads.html)  
> Install Vagrant Triggers from a terminal with `vagrant plugin install vagrant-triggers`  
> Install the latest version of Virtual Box from [here](https://www.virtualbox.org/wiki/Downloads)  

####**Setup:**
From your development directory run the following commands.

```sh
git clone git@github.com:30x/Dev_Setup.git
cd Dev_Setup/Single-Node
vagrant up
```
These commands will spin up a single node Kubernetes cluster. 

You should also be see the following directory structure:

```
Dev-Setup
├── LICENSE
├── README.md
├── Vagrantfile
├── ctl-setup.sh
├── kubeconfig
├── scripts
├── shared
└── user-data
```

####**Kubectl:**

```kubectl``` is the primary command you will use to interact with your Kubernetes cluster. You should ensure that this is command is in your path. To do this run the following commands:

```sh
wget https://storage.googleapis.com/kubernetes-release/release/v1.2.0/bin/darwin/amd64/kubectl
chmod 755 kubectl
mv kubectl /usr/local/bin
```  
At this point you should have a fully functioning Kubernetes cluster accesible through the ```kubectl``` command.

###**Docker:**

The VMs docker port is exposed over tcp by default. To remotely access it simply set your `DOCKER_HOST` environment variable with the following command.

```sh
source docker-setup.sh
```
If you plan to use this VM as your default development environment it is recommended that you add the above command to your `.bash_profile` or `.zshrc`.
