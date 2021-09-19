# Azure DevOps Agent Example

# Instructions
Run the included `cluster-with-registry.sh` script to create a k3d cluster and local Docker registry.

Run the included `build.sh` script to build the agent Docker image and push it to the local registry.

Replace the values in `vars.env` with your own and use it to create a `ConfigMap` Kubernetes resource.

Use the provided `deploy.yaml` manifest file to create a `Deployment` in the k3d cluster.

Congratulations, your self-hosted agents are up and running!