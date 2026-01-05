output "alb_controller_namespace" {
  value = kubernetes_namespace.alb_controller.metadata[0].name
}

output "alb_controller_service_account" {
  value = kubernetes_service_account.alb_controller.metadata[0].name
}

output "alb_controller_helm_release" {
  value = helm_release.alb_controller.name
}
