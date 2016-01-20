# Kubernetes and Vagrant Single-Node Setup


####**Prerequisites:** 
> Install latest version >= 1.6.2 of Vagrant from [here](www.vagrantup.com/downloads.html)  
> Install the latest version of Virtual Box from [here](https://www.virtualbox.org/wiki/Downloads)  

####**Setup:**
From your development directory run the following commands.

```
$ git clone
$ cd Single-Node
$ vagrant up
$ ./ctl-setup
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

```
$ vagrant ssh
```

####**Kubectl:**

```kubectl``` is the primary command you will use to interact with your Kubernetes cluster. You should ensure that this is command is in your path. To do this run the following commands:

```
$ curl -O https://storage.googleapis.com/kubernetes-release/release/v1.1.4/bin/darwin/amd64/kubectl
$ chmod +x kubectl
$ mv kubectl /usr/local/bin/kubectl
```  
At this point you should have a fully functioning Kubernetes cluster accesible through the ```kubectl``` command. 
