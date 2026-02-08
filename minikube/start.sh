#!/bin/bash
set -e

echo "🚀 Starting Minikube cluster..."
minikube start \
  --nodes=4 \
  --cpus=4 \
  --memory=8192 \
  --driver=docker

echo "📦 Creating namespaces..."
kubectl create namespace frontend
kubectl create namespace auth
kubectl create namespace ingress-nginx
kubectl create namespace cert-manager
kubectl create namespace argocd

echo "🔧 Installing ArgoCD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "⏳ Waiting for ArgoCD..."
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s

echo "✅ Cluster ready!"