terraform {
  required_version = ">= 1"

  backend "azurerm" {}

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      # version = "~> 1"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      # version = "~> 2"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      recover_soft_deleted_key_vaults = true
      purge_soft_delete_on_destroy    = true
    }

    template_deployment {
      delete_nested_items_during_deletion = true
    }

    virtual_machine {
      delete_os_disk_on_deletion = true
    }

    virtual_machine_scale_set {
      roll_instances_when_required = true
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = local.kube_config["host"]
    client_certificate     = base64decode(local.kube_config["client_certificate"])
    client_key             = base64decode(local.kube_config["client_key"])
    cluster_ca_certificate = base64decode(local.kube_config["cluster_ca_certificate"])
  }
}

provider "kubernetes" {
  host                   = local.kube_config["host"]
  client_certificate     = base64decode(local.kube_config["client_certificate"])
  client_key             = base64decode(local.kube_config["client_key"])
  cluster_ca_certificate = base64decode(local.kube_config["cluster_ca_certificate"])

  experiments {
    manifest_resource = true
  }
}