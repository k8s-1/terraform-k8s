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

# Need to wait a few seconds when removing the mycluster resource to give helm
# time to finish cleaning up.
#
# Otherwise, after `terraform destroy`:
# │ Error: uninstallation completed with 1 error(s): uninstall: Failed to purge
#   the release: release: not found

resource "time_sleep" "wait_30_seconds" {
  depends_on = [kubernetes_namespace.mycluster]

  destroy_duration = "30s"
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
