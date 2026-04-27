terraform {

  required_version = "~> 1.14"

  required_providers {

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}
