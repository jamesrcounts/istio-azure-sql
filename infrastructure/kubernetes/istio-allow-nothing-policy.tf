resource "kubernetes_manifest" "allow_nothing_policy" {
  for_each = kubernetes_namespace.ns

  manifest = yamldecode(<<EOF
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: allow-nothing
  namespace: ${each.value.metadata.0.name}
spec:
  {}
EOF
  )
}