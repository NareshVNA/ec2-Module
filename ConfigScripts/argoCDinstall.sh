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

echo "_______________Accessing Argo CD Services_______________"
kubectl get svc -n argocd
kubectl port-forward svc/argocd-server 8080:443 -n argocd
kubectl port-forward --address 0.0.0.0 svc/argocd-server 8080:443 -n argocd

echo "_______________Initial Argo CD Login_________________"

argocd admin initial-password -n argocd
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode && echo

argocd login localhost:8080
argocd cluster list
argocd app list

argocd logout localhost:8080

echo "________________Cleanup______________"

echo "________________Delete the Argo CD Namespace__________________"

kubectl delete ns argocd
