# Kubernetes and Vagrant Single-Node Setup

##Forked from https://github.com/coreos/coreos-kubernetes

####**Prerequisites:** 
> Install latest version >= 1.6.2 of Vagrant from [here](https://www.vagrantup.com/downloads.html)  
> Install Vagrant Triggers from a terminal with `vagrant plugin install vagrant-triggers`  
> Install the latest version of Virtual Box from [here](https://www.virtualbox.org/wiki/Downloads)  

Make sure you are using the hackathon branch!
```
git checkout hackathon
```

####**Kubectl:**

```kubectl``` is the primary command you will use to interact with your Kubernetes cluster. You should ensure that this is command is in your path. To do this run the following commands:

```sh
wget https://storage.googleapis.com/kubernetes-release/release/v1.2.3/bin/darwin/amd64/kubectl
chmod 755 kubectl
mv kubectl /usr/local/bin
```  
At this point you should have a fully functioning Kubernetes cluster accesible through the ```kubectl``` command.

##**Setup:**
From your development directory run the following commands.

```sh
git clone git@github.com:30x/Dev_Setup.git
cd Dev_Setup
git checkout hackathon
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


###**Kubectl Examples:**

>You can check the status of your pods at any time using:
>
```
kubectl get pods
```


Create a new nginx deployment using the stable version. This should create a single pod. 

```
kubectl create -f examples/nginx-stable.yaml
```



Update your nginx deployment to use the latest nginx version. This will start creating a new pod while terminating the old one.

```
kubectl apply -f examples/nginx-latest.yaml
```

Scale your nginx deployment to 3 pods. This will start creating 2 more pods of the existing deployment. 

```
kubectl scale deployment nginx-deployment --replicas=3
```
Expose the deployment as a service.

```
kubectl create -f examples/nginx-service.yaml
```

To test that the service is working we need to create a busybox pod to make a request from within the cluster.

```
export SERVICE_IP=$(kubectl get service nginx-service -o go-template='{{.spec.clusterIP}}')
export SERVICE_PORT=$(kubectl get service nginx-service -o go-template='{{(index .spec.ports 0).port}}')
echo "$SERVICE_IP:$SERVICE_PORT"
kubectl run busybox  --generator=run-pod/v1 --image=busybox --restart=Never --tty -i --env "SERVICE_IP=$SERVICE_IP,SERVICE_PORT=$SERVICE_PORT"
```

You should now be ssh'd into the busybox pod. Make the following call.

```
wget -qO- http://$SERVICE_IP:$SERVICE_PORT 
```

Now exit the busybox pod.

```
exit 
```

And cleanup the busybox pod.

```
kubectl delete pod busybox 
```

Cleanup the service.

```
kubectl delete svc nginx-service
```

Cleanup the deployment.

```
kubectl delete deployment nginx-deployment
```

###**Enrober Examples:**

To use enrober we need to get a valid Apigee JWT

```
export APIGEE_USERNAME="{YOUR APIGEE EMAIL}"
export APIGEE_PASSWORD="{YOUR APIGEE PASSWORD}"
```

Set your apigee token

```
export SSO_LOGIN_URL=https://login.e2e.apigee.net
export APIGEE_TOKEN=$(./get_token -u ${APIGEE_USERNAME}:${APIGEE_PASSWORD})
```

>Note that the Apigee tokens roll frequently so you may have to reset your token by running the above command again.


Now test you have a valid token. You should have a long JWT oAuth token

```
echo $APIGEE_TOKEN
```

Now we want to push an example build up. Note that you must be an org admin for this to work.

```
export APIGEE_ORG="{YOUR APIGEE ORG}"
```
Now we can start making calls to the `enrober` api.

First create a new environment.

```
curl -sL -w "responseCode:%{http_code} responseTime:%{time_total}\n" -X POST -H "Authorization: Bearer e30.e30.e30" -d '{
    "environmentName": "env1",
    "hostNames": ["host1"]
    }' \
"test.k8s.local/beeswax/deploy/api/v1/environmentGroups/$APIGEE_ORG/environments"
```

Create a new deployment in the above environment.

```
curl -sL -w "responseCode:%{http_code} responseTime:%{time_total}\n" -X POST -H "Authorization: Bearer e30.e30.e30" -d '{
    "deploymentName": "dep1",
    "publicHosts": "test.k8s.local",
    "privateHosts": "test.k8s.local",
    "replicas": 1,
    "pts": 
    {
        "apiVersion": "v1",
        "kind": "Pod",
        "metadata": {
            "name": "nginx",
            "labels": {
                "app": "nginx"
            },
            "annotations": {
                "publicPaths": "80:/",  
                "privatePaths": "80:/"
            }
        },
        "spec": {
            "containers": [{
                "name": "nginx",
                "image": "nginx:stable-alpine",
                "env": [{
                    "name": "PORT",
                    "value": "80"
                }],
                "ports": [{
                    "containerPort": 80
                }]
            }]
        }
    }
}' \
"test.k8s.local/beeswax/deploy/api/v1/environmentGroups/$APIGEE_ORG/environments/env1/deployments"
```

Update the previous deployment.

```
curl -sL -w "responseCode:%{http_code} responseTime:%{time_total}\n" -X PATCH -H "Authorization: Bearer e30.e30.e30" -d '{
    "replicas": 1,
    "pts":
        {
        "apiVersion": "v1",
        "kind": "Pod",
        "metadata": {
            "name": "nginx",
            "labels": {
                "app": "nginx"
            },
            "annotations": {
                "publicPaths": "80:/",  
                "privatePaths": "80:/"
            }
        },
        "spec": {
            "containers": [{
                "name": "nginx",
                "image": "nginx:1.11-alpine",
                "env": [{
                    "name": "PORT",
                    "value": "80"
                }],
                "ports": [{
                    "containerPort": 80
                }]
            }]
        }
    }
}' \
"test.k8s.local/beeswax/deploy/api/v1/environmentGroups/$APIGEE_ORG/environments/env1/deployments/dep1"
```

Scale the previous deployment.

```
curl -sL -w "responseCode:%{http_code} responseTime:%{time_total}\n" -X PATCH -H "Authorization: Bearer e30.e30.e30" -d '{
    "replicas": 3
}' \
"test.k8s.local/beeswax/deploy/api/v1/environmentGroups/$APIGEE_ORG/environments/env1/deployments/dep1"
```

To access the deployment you need to know the api key. You can get this with the following curl command, you will need to extract the publicSecret.

```
curl -sL -w "responseCode:%{http_code} responseTime:%{time_total}\n" -X GET -H "Authorization: Bearer e30.e30.e30" test.k8s.local/beeswax/deploy/api/v1/environmentGroups/$APIGEE_ORG/environments/env1
```

Export the publicSecret as an environment variable.

```
export PUBLIC_ROUTING_KEY="{key value}"
```

Access the deployment. You should see the default nginx response.

```
curl -sL -w "responseCode:%{http_code} responseTime:%{time_total}\n" -X GET -H "X-ROUTING-API-KEY: $PUBLIC_ROUTING_KEY" "http://test.k8s.local/"
```

Delete the deployment.

```
curl -sL -w "responseCode:%{http_code} responseTime:%{time_total}\n" -X DELETE -H "Authorization: Bearer e30.e30.e30" \
"test.k8s.local/beeswax/deploy/api/v1/environmentGroups/$APIGEE_ORG/environments/env1/deployments/dep1"
```

Delete the environment.

```
curl -sL -w "responseCode:%{http_code} responseTime:%{time_total}\n" -X DELETE -H "Authorization: Bearer e30.e30.e30" "test.k8s.local/beeswax/deploy/api/v1/environmentGroups/$APIGEE_ORG/environments/env1"
```
