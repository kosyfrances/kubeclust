# Kubeclust

[Kubeclust](https://kosyfrances.github.io/kubernetes-cluster/) sets up a kubernetes 1.13.2 cluster on three VirtualBox virtual machines (one master and two workers) running Ubuntu 18.04 LTS using [kubeadm](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/).

### Prerequisites
* [Virtual environment](https://docs.python.org/3/library/venv.html) with Python3
* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)

### Installation
In the virtual environment, run
```
$ pip install -r requirements.txt
```

### Create Virtual Machines
Run `vagrant up` to bring up three virtual machines.

The hostnames and IP addresses of the machines are as follows:

kubemaster — 192.168.99.20

worker1 – 192.168.99.21

worker2 – 192.168.99.22

### Create kubernetes cluster
In the virtual environment created earlier, run
```
$ make cluster
```
As soon as it is done, you can ssh into kubemaster to see the nodes and the pods in the cluster. They may take a while to get ready.
```
vagrant@kubemaster:~$ kubectl get nodes
NAME         STATUS     ROLES    AGE   VERSION
kubemaster   Ready      master   54s   v1.13.2
worker1      Ready      <none>   27s   v1.13.2
worker2      Ready      <none>   27s   v1.13.2

vagrant@kubemaster:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                 READY   STATUS    RESTARTS   AGE
kube-system   calico-node-6fkt5                    2/2     Running   0          67s
kube-system   calico-node-n972r                    2/2     Running   0          61s
kube-system   calico-node-v965s                    2/2     Running   0          61s
kube-system   coredns-86c58d9df4-9lb8f             1/1     Running   0          67s
kube-system   coredns-86c58d9df4-ht6f8             1/1     Running   0          67s
kube-system   etcd-kubemaster                      1/1     Running   0          14s
kube-system   kube-apiserver-kubemaster            1/1     Running   0          9s
kube-system   kube-controller-manager-kubemaster   1/1     Running   0          31s
kube-system   kube-proxy-vv78z                     1/1     Running   0          61s
kube-system   kube-proxy-x2mn9                     1/1     Running   0          61s
kube-system   kube-proxy-ztq8q                     1/1     Running   0          67s
kube-system   kube-scheduler-kubemaster            1/1     Running   0          21s
```

### Tear down cluster
```
$ make clean
```
This will drain the nodes, make sure that they are empty before shutting them down and reset all kubeadm installed state.
