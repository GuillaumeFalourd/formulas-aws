package tpl

const (
	HelmMaintf = `
data "helm_repository" "codecentric" {
  name = "codecentric"
  url  = "https://codecentric.github.io/helm-charts"
}

data "helm_repository" "loki" {
  name = "loki"
  url  = "https://grafana.github.io/loki/charts"
}


# -------------------------------------------- misc things required to run, expose and auto scale things on k8s

resource "kubernetes_namespace" "k8s-extras" {
  metadata {
    name = "k8s-extras"
  }
}

resource "helm_release" "cluster-autoscaler" {
  name             = "cluster-autoscaler"
  repository       = "https://kubernetes.github.io/autoscaler"
  chart            = "cluster-autoscaler"
  version          = "9.1.0"
  timeout          = "600"
  namespace        = "k8s-extras"

  set {
    name  = "autoDiscovery.clusterName"
    value = var.kubernetes_cluster_name
  }

  set {
    name  = "autoDiscovery.tags"
    value = "kubernetes.io/cluster/${var.kubernetes_cluster_name}"
  }

  set {
    name  = "cloud-provider"
    value = "aws"
  }

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "rbac.create"
    value = true
  }

  set {
    name  = "image.tag"
    value = "v1.18.1"
  }

  depends_on = [
    kubernetes_cluster_role_binding.tiller,
    kubernetes_service_account.tiller
  ]
}


resource "helm_release" "external-dns" {
  name             = "external-dns"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "external-dns"
  version          = "3.4.1"
  namespace        = "k8s-extras"

  set {
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "aws.zoneType"
    value = "public"
  }

  set {
    name  = "txtOwnerId"
    value = var.dns_zone_id
  }

  set {
    name  = "rbac.create"
    value = true
  }

  set {
    name  = "policy"
    value = "sync"
  }

  depends_on = [
    helm_release.aws-load-balancer-controller
  ]
}


resource "helm_release" "aws-load-balancer-controller" {
  name             = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  version          = "1.1.2"
  namespace        = "k8s-extras"

  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.sa-east-1.amazonaws.com/amazon/aws-load-balancer-controller"
  }


  set {
    name  = "clusterName"
    value = var.kubernetes_cluster_name
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

}

	`

	HelmVariablestf = `
variable "kubernetes_cluster" {
  default = ""
}

variable "kubernetes_cluster_name" {
  default = ""
}

variable "region" {
  default = ""
}

variable "dns_zone_id" {
  default = ""
}

variable "vpc_id" {
  default = ""
}
	`
)
