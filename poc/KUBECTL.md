# Kubectl commands

```bash
# Get Credentials
$ az aks get-credentials --resource-group <Resource-Group-Name> --name <Cluster-Name>
$ az aks get-credentials --resource-group aks-dev-rg --name aksdevweu

# List Kubernetes Worker Nodes
$ kubectl get nodes 
$ kubectl get nodes -o wide
```