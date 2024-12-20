#!/bin/bash

# Ensure the required environment variables are set
if [ -z "$TOKEN_NAME" ] || [ -z "$TOKEN_VALUE" ]; then
  echo "TOKEN_NAME and TOKEN_VALUE environment variables must be set."
  exit 1
fi

# Base64 encode the environment variables
ENCODED_TOKEN_NAME=$(echo -n $TOKEN_NAME | base64)
ENCODED_TOKEN_VALUE=$(echo -n $TOKEN_VALUE | base64)

# Replace placeholders in pve-secret.yml
sed -i -e "s#{TOKEN_NAME}#${ENCODED_TOKEN_NAME}#g" ./manifests/pve-secret.yml
sed -i -e "s#{TOKEN_VALUE}#${ENCODED_TOKEN_VALUE}#g" ./manifests/pve-secret.yml

# Apply the Kustomize configuration
kubectl apply -k manifests/