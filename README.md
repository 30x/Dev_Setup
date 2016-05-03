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
cd Dev_Setup
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
├── docker-setup.sh
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

The VMs docker port is exposed over tcp by default. To remotely access it run the following command which will properly configure your environment variables.

```sh
source docker-setup.sh
```

If you plan to use this VM as your default development environment it is recommended that you add the above command to your `.bash_profile` or `.zshrc`.


##**Permissions:**

By default all users only have read only access to the kubernetes api server. Therea are two users with elevated permissions.

The `kube-admin` user which is the default for `kubectl` has write access to all resources.

The `admin` service account in the default namespace has write access to all resources.
