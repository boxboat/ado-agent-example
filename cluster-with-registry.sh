k3d registry create myregistry.localhost --port 127.0.0.1:12345
k3d cluster create --registry-use k3d-myregistry.localhost:12345  --agents 2
