# resource "kubernetes_manifest" "peer_authentication" {
#   depends_on = [
#     helm_release.istio_base
#   ]

#   manifest = yamldecode(
#     <<EOF
# apiVersion: security.istio.io/v1beta1
# kind: PeerAuthentication
# metadata:
#   name: "default"
#   namespace: ${kubernetes_namespace.istio_system.metadata.0.name}
# spec:
#   mtls:
#     mode: STRICT
# EOF
#   )
# }