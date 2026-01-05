resource "kubernetes_namespace" "alb_controller" {
  metadata {
    name = "kube-system"
  }
  depends_on = [
    module.eks.kubeconfig
  ]
}

resource "kubernetes_service_account" "alb_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam.alb_ingress_role_arn
    }
  }
  depends_on = [
    kubernetes_namespace.alb_controller
  ]
}

resource "kubernetes_cluster_role" "alb_controller" {
  metadata {
    name = "aws-load-balancer-controller-role"
  }
  rule {
    api_groups = [""]
    resources  = ["namespaces"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources  = ["events", "endpoints", "services", "pods", "secrets"]
    verbs      = ["create", "get", "list", "patch", "update", "watch", "delete"]
  }
  rule {
    api_groups = ["discovery.k8s.io"]
    resources  = ["endpointslices"]
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
  }
  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses", "ingressclasses"]
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
  }
  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses/status", "ingressclasses/status"]
    verbs      = ["update"]
  }
  rule {
    api_groups = ["elbv2.k8s.aws"]
    resources  = ["targetgroups", "targetgroupbindings", "loadbalanceroptions"]
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
  }
  rule {
    api_groups = ["elbv2.k8s.aws"]
    resources  = ["targetgroups/status", "targetgroupbindings/status", "loadbalanceroptions/status"]
    verbs      = ["update"]
  }
  rule {
    api_groups = ["acme.cert-manager.io"]
    resources  = ["challenges"]
    verbs      = ["get", "list", "watch", "patch", "update"]
  }
  rule {
    api_groups = ["acme.cert-manager.io"]
    resources  = ["challenges/status"]
    verbs      = ["update"]
  }
  depends_on = [
    kubernetes_namespace.alb_controller
  ]
}

resource "kubernetes_cluster_role_binding" "alb_controller" {
  metadata {
    name = "aws-load-balancer-controller-rolebinding"
  }
  subjects {
    kind      = "ServiceAccount"
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
  }
  role_ref {
    kind = "ClusterRole"
    name = "aws-load-balancer-controller-role"
  }
  depends_on = [
    kubernetes_cluster_role.alb_controller
  ]
}

resource "helm_release" "alb_controller" {
  name             = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  version          = "1.8.0"
  namespace        = "kube-system"
  create_namespace = false

  set {
    name  = "clusterName"
    value = module.eks.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "vpcId"
    value = module.vpc.vpc_id
  }

  depends_on = [
    kubernetes_cluster_role_binding.alb_controller
  ]
}

output "alb_controller_namespace" {
  value = kubernetes_namespace.alb_controller.metadata[0].name
}

output "alb_controller_service_account" {
  value = kubernetes_service_account.alb_controller.metadata[0].name
}

output "alb_controller_helm_release" {
  value = helm_release.alb_controller.name
}
