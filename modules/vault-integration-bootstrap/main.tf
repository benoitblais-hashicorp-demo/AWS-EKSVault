locals {
  labels = {
    "app.kubernetes.io/managed-by" = "terraform"
    "demo.hashicorp.com/cluster"   = var.cluster_name
    "demo.hashicorp.com/mode"      = var.integration_mode
  }
}

resource "kubernetes_config_map_v1" "vault_connection" {
  metadata {
    name      = "vault-connection"
    namespace = var.namespace
    labels    = local.labels
  }

  data = {
    address = var.vault_address
  }
}

resource "null_resource" "delete_stuck_job" {
  count = var.cluster_endpoint != "" && var.cluster_token != "" ? 1 : 0

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "curl -sk -X DELETE -H 'Authorization: Bearer ${var.cluster_token}' '${var.cluster_endpoint}/apis/batch/v1/namespaces/${var.namespace}/jobs/pdcc-vault-secrets-operator' || exit 0"
  }
}

resource "helm_release" "vault_secrets_operator" {
  name             = "vault-secrets-operator"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault-secrets-operator"
  namespace        = var.namespace
  create_namespace = false
  skip_crds        = false
  wait             = true
  timeout          = 600

  depends_on = [null_resource.delete_stuck_job]

  values = [yamlencode({
    installCRDs = true
  })]
}

resource "helm_release" "secrets_store_csi_driver" {
  count = var.integration_mode == "vso_csi" ? 1 : 0

  name             = "secrets-store-csi-driver"
  repository       = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart            = "secrets-store-csi-driver"
  namespace        = "kube-system"
  create_namespace = false
  wait             = true
  timeout          = 600

  values = [yamlencode({
    syncSecret = {
      enabled = true
    }
    enableSecretRotation = true
  })]
}
