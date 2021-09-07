#!/usr/bin/env bash
set -x

export NS='svcs'
export SOURCE_POD=$(kubectl get pod -l app=sleep -n ${NS} -o jsonpath='{.items..metadata.name}')
kubectl exec "$SOURCE_POD" -n ${NS} -c sleep -- curl -sSI https://www.google.com | grep  "HTTP/"
kubectl exec "$SOURCE_POD" -n ${NS} -c sleep -- curl -sI https://edition.cnn.com | grep "HTTP/"
kubectl exec "$SOURCE_POD" -n ${NS} -c sleep -- curl -sS http://httpbin.org/headers
kubectl logs "$SOURCE_POD" -n ${NS} -c istio-proxy | tail
