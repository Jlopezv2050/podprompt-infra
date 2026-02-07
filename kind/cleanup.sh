#!/bin/bash
set -e

echo "🗑️  Deleting KIND cluster..."
kind delete cluster --name podprompt

echo "✅ Cluster deleted!"