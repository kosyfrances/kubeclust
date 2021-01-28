# Kubeclust

[Kubeclust](https://kosyfrances.github.io/kubernetes-cluster/) sets up a kubernetes 1.20.2 cluster on three VirtualBox virtual machines (one master and two workers) running Ubuntu 20.04 LTS using [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/).

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
NAME         STATUS   ROLES                  AGE     VERSION
kubemaster   Ready    control-plane,master   7m2s    v1.20.2
worker1      Ready    <none>                 6m33s   v1.20.2
worker2      Ready    <none>                 6m33s   v1.20.2

vagrant@kubemaster:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                       READY   STATUS    RESTARTS   AGE
kube-system   calico-kube-controllers-744cfdf676-wnsth   1/1     Running   0          8m5s
kube-system   calico-node-6c7cg                          1/1     Running   0          8m5s
kube-system   calico-node-fpwfs                          1/1     Running   0          7m55s
kube-system   calico-node-j87dn                          1/1     Running   0          7m55s
kube-system   coredns-74ff55c5b-6jgb6                    1/1     Running   0          8m5s
kube-system   coredns-74ff55c5b-9lw2b                    1/1     Running   0          8m5s
kube-system   etcd-kubemaster                            1/1     Running   0          8m19s
kube-system   kube-apiserver-kubemaster                  1/1     Running   0          8m19s
kube-system   kube-controller-manager-kubemaster         1/1     Running   0          8m19s
kube-system   kube-proxy-dwfzq                           1/1     Running   0          7m55s
kube-system   kube-proxy-r7cqp                           1/1     Running   0          8m5s
kube-system   kube-proxy-wpwg5                           1/1     Running   0          7m55s
kube-system   kube-scheduler-kubemaster                  1/1     Running   0          8m19s
```

### Tear down cluster
```
$ make clean
```
This will drain the nodes, make sure that they are empty before shutting them down and reset all kubeadm installed state.
