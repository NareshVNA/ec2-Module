## Update Your System

sudo dnf update -y

##This command updates the package index on your instance of AWS Linux 2023. It's a good practice to update your system before installing new software to ensure you have the latest security patches and software compatibility.

## Install Docker

sudo dnf install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER && newgrp docker

##Docker is required for Minikube to create the Kubernetes cluster. These commands install Docker, start the Docker service, enable it to launch at boot, and add your user to the Docker group so that you can run Docker commands without sudo.

## Install kubectl

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client -o json

##`kubectl` is the command line tool for interacting with the Kubernetes cluster. This sequence of commands downloads the latest stable version of `kubectl`, makes it executable, and moves it to a directory in your PATH for easy access.

## Install Minikube

wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube
minikube version
minikube start --driver=docker
minikube status
