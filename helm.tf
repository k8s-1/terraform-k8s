resource "helm_release" "example" {
  name       = "my-redis-release"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "6.0.1"

  values = [
    "${file("values.yaml")}"
  ]

  # setting chart value with "set"
  set {
    name  = "cluster.enabled"
    value = "true"
  }

  # setting chart value with "set"
  set {
    name  = "metrics.enabled"
    value = "true"
  }

  # setting chart value with "set"
  set {
    name  = "service.annotations.prometheus\\.io/port"
    value = "9127"
    type  = "string"
  }
}
