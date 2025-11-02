provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "ollama" {
  name       = "ollama-chart"
  chart      = "./charts/ollama-chart"
  namespace  = "default"
}

resource "helm_release" "openwebui" {
  name       = "openwebui-chart"
  chart      = "./charts/openwebui-chart"
  namespace  = "default"
  depends_on = [helm_release.ollama]

  set = [
    {
      name  = "service.type"
      value = "LoadBalancer"
    },
    {
      name  = "service.port"
      value = "80"
    },
    {
      name  = "service.targetPort"
      value = "8080"
    }
  ]
}
