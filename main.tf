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

resource "kubernetes_namespace" "mycluster" {
  lifecycle {
    ignore_changes = [metadata]
  }

  metadata {
    name = "mycluster"
    labels = {
      role            = "mycluster-system"
      access          = "mycluster-system"
      istio-injection = "enabled"
    }
  }
}

resource "kubernetes_namespace" "mycluster-fn" {
  lifecycle {
    ignore_changes = [metadata]
  }

  metadata {
    name = "mycluster-fn"
    labels = {
      role            = "mycluster-fn"
      istio-injection = "enabled"
    }
  }
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
