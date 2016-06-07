# Kubernetes and Vagrant Single-Node Setup

##Forked from https://github.com/coreos/coreos-kubernetes

####**Prerequisites:** 
> Install latest version >= 1.6.2 of Vagrant from [here](https://www.vagrantup.com/downloads.html)  
> Install Vagrant Triggers from a terminal with `vagrant plugin install vagrant-triggers`  
> Install the latest version of Virtual Box from [here](https://www.virtualbox.org/wiki/Downloads)  

##**Setup:**
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


>**Please note that cluster setup can take some time and things may run slowly for the first 10 minutes or so.**

##**Kubectl:**

```kubectl``` is the primary command you will use to interact with your Kubernetes cluster. You should ensure that this is command is in your path. To do this run the following commands:

```sh
wget https://storage.googleapis.com/kubernetes-release/release/v1.2.3/bin/darwin/amd64/kubectl
chmod 755 kubectl
mv kubectl /usr/local/bin
```  
At this point you should have a fully functioning Kubernetes cluster accesible through the ```kubectl``` command.

##**Docker:**

The VMs docker port is exposed over tcp by default. To remotely access it run the following command which will properly configure your environment variables.

```sh
source docker-setup.sh
```

If you plan to use this VM as your default development environment it is recommended that you add the following command to your `.bash_profile` or `.zshrc`. 

>Assuming you cloned `Dev_Setup` into your root directory.

```
source ~/Dev_Setup/docker-setup.sh
```

##**Hackathon Specifics:**

For use during the hackathon you will want to configure your systems `/etc/hosts` file so that you can locally access your pods that are being routed with the [`30x/k8s-pods-ingress`](https://github.com/30x/k8s-pods-ingress). 

Add the following line to your `/etc/hosts` file:

```
#Local K8s Cluster
172.17.4.99 test.k8s.local
```

When deploying to the local vagrant environment make your pods `publicHost` and `privateHost` annotations `test.k8s.local`. They will then be reachable from your local machine at that address. 