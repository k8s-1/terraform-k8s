provider "helm" {
  kubernetes {
    host = var.k8s_host

    client_certificate     = base64decode(var.k8s_client_certificate)
    client_key             = base64decode(var.k8s_client_key)
    cluster_ca_certificate = base64decode(var.k8s_cluster_ca_certificate)
  }
}

resource "helm_release" "example" {
  name       = "podinfo"
  repository = "https://stefanprodan.github.io/podinfo"
  chart      = "podinfo"
  version    = "6.7.0"

  # import a values.yaml for our chart
  values = [
    "${file("values.yaml")}"
  ]

  # chart values can also be set with "set"
  set {
    name  = "ui.color"
    value = "#34577c"
  }
}
