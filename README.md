# Example Repository on Terraforming Kubernetes Resources

## A word of caution
* In general avoid this, it's a box in a box (and there's better ways to go about it in a k8s-native way e.g. fluxcd, argocd)
* The only k8s resource you want to terraform is e.g. network CNI -> flux/argocd
* Can be useful for the following timelined approach e.g.
    1. Terraform basic infrastructure incl. controlplane
    2. Terraform network CNI (if using own network CNI, pre-req of flux)
    3. Terraform flux/argocd
* From there on, you've reached a point where any configuration is best done in a k8s-native way, not with terraform e.g. other infrastructure resources and k8s application config
* Use kubernetes priorityClass to ensure appropriate scheduling in cluster, avoid creating confusing terraform code that bootstraps resources

