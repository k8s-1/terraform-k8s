variable "k8s_host" {
  description = "Hostname of the Kubernetes API server (url format e.g. https://ip_addr:6443)."
  type        = string
}

variable "k8s_client_certificate" {
  description = "Base64 encoded client cert for TLS auth to API server"
  type        = string
}

variable "k8s_client_key" {
  description = "Base64 encoded client key for TLS auth to API server"
  type        = string
}

variable "k8s_cluster_ca_certificate" {
  description = "Base64 encoded CA cert for TLS auth to API server"
  type        = string
}
