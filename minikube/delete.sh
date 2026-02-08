#!/bin/bash
set -e

echo "🗑️  Deleting Minikube cluster..."
minikube delete

echo "✅ Cluster deleted!"