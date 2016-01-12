# Getting Started with Kubernetes and Vagrant

### ***Stable Versions***

####**Prerequisites:** 
> Install latest version >= 1.6.2 of Vagrant from [here](www.vagrantup.com/downloads.html)  
> Install the latest version of Virtual Box from [here](https://www.virtualbox.org/wiki/Downloads)  

####**Setup:**
From your home directory run the following commands.

```
$ wget https://github.com/kubernetes/kubernetes/releases/download/v1.1.4/kubernetes.tar.gz  
$ tar -xf kubernetes.tar.gz 
$ cd kubernetes  
$ export KUBERNETES_PROVIDER=vagrant
$ cluster/kube-up.sh
```
These commands will spin up a Kubernetes cluster. The default setup creates a single Master node and a single minion node. 

You should also be see the following directory structure:

```
kubernetes  
├── LICENSE 
├── README.md  
├── Vagrantfile
├── cluster/
├── contrib/
├── docs/
├── examples/
├── platforms/
├── server/
└── third_party/
```

####**SSH Access:**

You can access these nodes directly through ssh.

```
$ vagrant ssh master
$ vagrant ssh minion-1
```

####**Kubectl:**

```kubectl``` is the primary command you will use to interact with your Kubernetes cluster. You should ensure that this is command is in your path. To do this run the following command:

```
$ sudo cp $HOME/kubernetes/platforms/darwin/amd64/kubectl /usr/local/bin/kubectl
```  
At this point you should have a fully functioning Kubernetes cluster accesible through the ```kubectl``` command. 

####**Modifications:**

> **Note:**
 Anytime you modify your Kubernetes ```RUNTIME_CONFIG``` you must restart your cluster. This is done by running the ```cluster/kube-down.sh```and```cluster/kube-up.sh``` commands.

#####Enable Beta Features

To change the default vagrant configuration you must modify your config-default.sh file. This is located under the following path: 

`kubernetes/cluster/vagrant/config-default.sh`

To modify this file first copy it into a new file to preserve the original and ensure Kubernetes looks for your copy. 

```
$ cp config-default.sh config-mine.sh
$ export KUBE_CONFIG_FILE=config-mine.sh
```

To enable beta features change the `RUNTIME_CONFIG` value. This should be line 93 in the default file. 
Change this line to be:

```
RUNTIME_CONFIG="api/v1=true,config=extensions/v1beta1/daemonsets=true,extensions/v1beta1/deployments=true,extensions/v1beta1/jobs=true,extensions/v1beta1/ingress=true"
```

-

####**Testing:**

- Remove old ```~/.kube/config``` file 

####**Todo List**:
- Add documentation for Kubernetes Alpha releases.

###**Notes:**

> Remove this section when guide is finished.

- Using Vagrantfile for convenient setup
- Using Coreos as base OS
- Should generate ```~/.kube/config``` file automatically on vagrant up
- Should remove old ```~/.kube/config``` file on vagrant destroy
- Preferably 2 total commands for user to run
- Comments don't work on github
