terraform {

  required_version = ">= 1.0.0"

  required_providers {

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "5.8.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.1"
    }

  }
}