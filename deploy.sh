#!/bin/bash

# Ensure the required environment variables are set
if [ -z "$TOKEN_NAME" ] || [ -z "$TOKEN_VALUE" ]; then
  echo "TOKEN_NAME and TOKEN_VALUE environment variables must be set."
  exit 1
fi

# Replace placeholders in pve-secret.yml
sed -i '' "s/\${TOKEN_NAME}/$(echo -n $TOKEN_NAME | base64)/" manifests/pve-secret.yaml
sed -i '' "s/\${TOKEN_VALUE}/$(echo -n $TOKEN_VALUE | base64)/" manifests/pve-secret.yaml

# Apply the Kustomize configuration
kubectl apply -k manifests/