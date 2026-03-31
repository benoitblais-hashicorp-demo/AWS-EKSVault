output "edr_helm_release" {
  description = "Name of the Uptycs EDR Helm release."
  value       = helm_release.uptycs_edr.name
}

output "edr_namespace" {
  description = "Namespace where Uptycs EDR is installed."
  value       = kubernetes_namespace_v1.edr.metadata[0].name
}
