resource "kubernetes_manifest" "allow_apps_to_svc" {
  depends_on = [
    module.istio
  ]

  manifest = yamldecode(<<EOF
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: "httpbin-viewer"
  namespace: ${kubernetes_namespace.ns["svcs"].metadata.0.name}
spec:
  selector:
    matchLabels:
      app: httpbin
  action: ALLOW
  rules:
  - to:
    - operation:
        methods: ["GET"]
EOF
  )
}