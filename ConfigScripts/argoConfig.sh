
echo "_______________Accessing Argo CD Services_______________"
kubectl get svc -n argocd

echo "_______________port forwarding________________"
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

kubectl delete ns argocd */