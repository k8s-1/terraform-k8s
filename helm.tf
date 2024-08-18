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
