terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.6.1"
    }
  }
}

provider "kubernetes" {
  host = var.k8s_host

  client_certificate     = base64decode(var.k8s_client_certificate)
  client_key             = base64decode(var.k8s_client_key)
  cluster_ca_certificate = base64decode(var.k8s_cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host = var.k8s_host

    client_certificate     = base64decode(var.k8s_client_certificate)
    client_key             = base64decode(var.k8s_client_key)
    cluster_ca_certificate = base64decode(var.k8s_cluster_ca_certificate)
  }
}

resource "kubernetes_manifest" "openfaas_fn_nodeinfo" {
  manifest = {
    "apiVersion" = "openfaas.com/v1"
    "kind" = "Pod"
    "metadata" = {
      "name" = "some-pod"
    }
    "spec" = {
      "image" = "nginx:latest"
      "limits" = {
        "cpu" = "200m"
        "memory" = "256Mi"
      }
      "name" = "some-pod-container"
      "requests" = {
        "cpu" = "10m"
        "memory" = "128Mi"
      }
    }
  }
}
