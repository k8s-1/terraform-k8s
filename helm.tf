resource "helm_release" "example" {
  name       = "my-redis-release"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "6.0.1"

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
