# Kubernetes and Vagrant Single-Node Setup


####**Prerequisites:** 
> Install latest version >= 1.6.2 of Vagrant from [here](www.vagrantup.com/downloads.html)  
> Install the latest version of Virtual Box from [here](https://www.virtualbox.org/wiki/Downloads)  

####**Setup:**
From your development directory run the following commands.

```sh
git clone
cd Single-Node
vagrant up
./ctl-setup
```
These commands will spin up a single node Kubernetes cluster. 

You should also be see the following directory structure:

```
Single-Node
├── README.md
├── Vagrantfile
├── ctl-setup.sh
├── kubeconfig
├── scripts
├── shared
├── ssl
└── user-data
```

####**SSH Access:**

You can access the VM directly through ssh.

```sh
vagrant ssh
```

####**Kubectl:**

```kubectl``` is the primary command you will use to interact with your Kubernetes cluster. You should ensure that this is command is in your path. To do this run the following commands:

```sh
brew install kubernetes-cli
```  
At this point you should have a fully functioning Kubernetes cluster accesible through the ```kubectl``` command. 
