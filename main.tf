provider "kubernetes" {
    config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "plataform" {
    metadata {
        name = "plataform-namespace"
    }
}

resource "kubernetes_deployment" "plataform" {
  metadata {
      name = "plataform-deployment"
      namespace = kubernetes_namespace.plataform.metadata[0].name
  }

  spec {
      replicas = 2
  
      selector {
        match_labels = {
            app = "plataform-tooling"
        }
      }
  
      template {
        metadata {
            labels = {
                app = "plataform-tooling"
            }
        }
  
        spec {
          container {
              name = "plataform-tooling-container"
              image = "nginx:1.14.2"
              
              port {
                  container_port = 80
              }
          }
        }
      }
  }
}
