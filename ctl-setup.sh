#!/bin/sh
kubectl config set-cluster vagrant --server=https://172.17.4.99:443 --certificate-authority=$PWD/ssl/ca.pem
kubectl config set-credentials vagrant-admin --certificate-authority=$PWD/ssl/ca.pem --client-key=$PWD/ssl/admin-key.pem --client-certificate=$PWD/ssl/admin.pem
kubectl config set-context vagrant --cluster=vagrant --user=vagrant-admin
kubectl config use-context vagrant

#Wait for kubernetes
echo "Waiting for Kubernetes cluster to become available..."

until $(kubectl cluster-info &> /dev/null); do
    sleep 1
done

#Going to force "kubectl proxy --port=8080 &" to be run at start so that we can hit the cluster
kubectl proxy --port=8080 &

#Create Apigee namespace
kubectl create ns apigee

#Create k8s-router
kubectl create -f k8s-router.yaml --namespace=apigee

#Create enrober
kubectl create -f enrober.yaml --namespace=apigee

echo "Kubernetes cluster is up."

