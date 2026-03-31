# k8s-edr-uptycs

Deploys the Uptycs EDR agent into an EKS cluster using Helm.

This module is intended to be orchestrated by Terraform Stacks for each EKS lane.

## Notes

- Default chart repository: `https://uptycslabs.github.io/kspm-helm-charts`.
- Default chart name: `k8sosquery`.
- Uptycs-managed values files (downloaded from IBM/Uptycs docs) can be merged through `additional_values_yaml`.
- In this repository, stack variable `edr_k8sosquery_values_yaml` is intended for secure runtime injection of the downloaded values content so sensitive enrollment data is not committed to git.
