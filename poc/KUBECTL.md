# Kubectl commands

```bash
# Get Credentials
$ az aks get-credentials --resource-group <Resource-Group-Name> --name <Cluster-Name>
$ az aks get-credentials --resource-group aks-dev-rg --name aksdevweu

# List Kubernetes Worker Nodes
$ kubectl get nodes 
$ kubectl get nodes -o wide

$ kubectl create namespace spark-cluster
$ kubectl apply -f ./kube-manifests

# enter kubernetes cluster in shell -> use nsloopup etc for debugging
$ kubectl run -n spark-cluster dnsutils --image=busybox:1.28 --rm -it --restart=Never -- sh

$ kubectl get nodes --label-columns agendpool
$ kubectl label node aks-sparkpool001-87494612-vmss00000{0&1&2} nodepool=sparkpool001
```