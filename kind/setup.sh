#!/bin/bash
set -e

echo "🚀 Creating KIND cluster..."
kind create cluster --config kind-config.yaml

echo "⏳ Waiting for cluster to be ready..."
kubectl wait --for=condition=Ready nodes --all --timeout=300s

echo "📦 Creating namespaces..."
kubectl create namespace frontend
kubectl create namespace auth
kubectl create namespace ingress-nginx
kubectl create namespace cert-manager
kubectl create namespace argocd

echo "✅ Cluster ready!"
echo ""
echo "Next steps:"
echo "1. Install ArgoCD: kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"