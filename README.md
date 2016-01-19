# Getting Started with Kubernetes and Vagrant


####**Prerequisites:** 
> Install latest version >= 1.6.2 of Vagrant from [here](www.vagrantup.com/downloads.html)  
> Install the latest version of Virtual Box from [here](https://www.virtualbox.org/wiki/Downloads)  

####**Setup:**
From your development directory run the following commands.

```
$ git clone
$ vagrant up
$ ./ctl-setup
```
These commands will spin up a Kubernetes cluster. 

You should also be see the following directory structure:

```
Dev_Setup/
├── LICENSE
├── README.md
├── Vagrantfile
├── addons
├── config.rb
├── ctl-setup.sh
├── etcd-cloud-config.yaml
├── kubeconfig
└── scripts
```

####**SSH Access:**

You can access these nodes directly through ssh.

```
$ vagrant ssh c1
$ vagrant ssh w1
$ vagrant ssh w2
.
.
.
```

####**Kubectl:**

```kubectl``` is the primary command you will use to interact with your Kubernetes cluster. You should ensure that this is command is in your path. To do this run the following commands:

```
$ curl -O https://storage.googleapis.com/kubernetes-release/release/v1.1.4/bin/darwin/amd64/kubectl
$ chmod +x kubectl
$ mv kubectl /usr/local/bin/kubectl
```  
At this point you should have a fully functioning Kubernetes cluster accesible through the ```kubectl``` command. 


-
###**References**: 

- https://coreos.com/kubernetes/docs/latest/kubernetes-on-vagrant.html
- https://github.com/coreos/coreos-kubernetes
- http://kubernetes.io/v1.1/docs/user-guide/kubeconfig-file.html
- http://kubernetes.io/v1.1/docs/user-guide/accessing-the-cluster.html

###**TROUBLESHOOTING**:
- `controller-install.sh` isnt running on controller node.