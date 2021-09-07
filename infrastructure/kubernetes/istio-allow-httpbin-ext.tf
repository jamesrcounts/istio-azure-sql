resource "kubernetes_manifest" "allow_httpbin_ext" {
  manifest = yamldecode(<<EOF
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: httpbin-ext
  namespace: ${data.kubernetes_namespace.istio_system.metadata.0.name}
spec:
  hosts:
  - httpbin.org
  ports:
  - number: 80
    name: http
    protocol: HTTP
  resolution: DNS
  location: MESH_EXTERNAL
EOF
  )
}