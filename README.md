# Example Repository on Terraforming Kubernetes Resources

## A word of caution
* Avoid this, it's a box in a box (and there's better ways to go about it in a k8s-native way e.g. fluxcd, argocd)
* The only k8s resource you want to terraform is e.g. network CNI -> flux/argocd
* Can be useful for the following timelined approach e.g.
    1. First, terraform basic infrastructure incl. controlplane e.g. kubernetes-ready VM's + controlplanes + CNI
    2. Next, terraform flux/argocd
* From there on, you've reached a point where any configuration is best done in a k8s-native way, not with terraform e.g. other infrastructure resources and k8s application config
* Use kubernetes priorityClass to ensure appropriate scheduling in cluster, avoid creating confusing terraform code that configures kubernetes resources unless really necessary

## Get started
```
kind create cluster --name=mycluster

kubectl config view --context=kind-mycluster --raw --output="go-template-file=cluster.tfvars.gotemplate" > terraform.tfvars

terraform init

terraform apply

kubectl port-forward svc/podinfo 8888:http
```
* Note: do not to mix cluster creation and resource creation in terraform production
* In this case, we have created the kindcluster manually and fetch the necessary values from the kubeconfig, go-templated into terraform.tfvars
