resource "kubernetes_manifest" "allow_google" {
  manifest = yamldecode(<<EOF
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: google
  namespace: ${data.kubernetes_namespace.istio_system.metadata.0.name}
spec:
  hosts:
  - www.google.com
  ports:
  - number: 443
    name: https
    protocol: HTTPS
  resolution: DNS
  location: MESH_EXTERNAL
EOF
  )
}