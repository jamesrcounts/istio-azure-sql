resource "kubernetes_manifest" "cs" {
  for_each = kubernetes_namespace.ns

  manifest = yamldecode(<<EOF
apiVersion: secrets-store.csi.x-k8s.io/v1alpha1
kind: SecretProviderClass
metadata:
  name: connection-strings
  namespace: ${each.value.metadata.0.name}
spec:
  provider: azure
  parameters:
    useVMManagedIdentity: "true"
    userAssignedIdentityID: "${data.azurerm_kubernetes_cluster.aks.kubelet_identity[0].client_id}"
    keyvaultName: "${module.configuration.key_vault.name}"
    objects:  |
      array:
        - |
          objectName: test-private-connection-string
          objectType: secret
    tenantId: "${module.configuration.key_vault.tenant_id}"
EOF
  )
}