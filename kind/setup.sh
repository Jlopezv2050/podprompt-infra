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

echo "🔧 Installing ArgoCD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "⏳ Waiting for ArgoCD to be ready..."
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s

echo "✅ Cluster ready with ArgoCD installed!"
echo ""
echo "Access ArgoCD UI:"
echo "  kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo ""
echo "Get admin password:"
echo "  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"