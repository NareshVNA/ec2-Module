echo "Installation of Argo CD and Argo CD CLI"

echo "___________Create Argo CD Namespace___________"

kubectl create namespace argocd

echo "__________Install Argo CD___________"

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl get all --namespace=argocd

echo "_______________Install Argo CD CLI_____________"

curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
