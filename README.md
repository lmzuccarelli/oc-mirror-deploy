# Overview

## Using ansible to install and deploy oc-mirror and mirror-registry

- clone this repo
- cd into oc-mirror-deploy/ansible

## Prerequisites

- All servers have ssh access with ssh keys copied to authorized_keys on each server (ansible requirement)
- Ansible has been installed on your local development system

## Before starting

Ansible uses variables for each playbook. Please change/add/update the variable files they are usually found under roles/vars folder

i.e 
ansible
  - roles
    - tasks
    - vars
      - xxx.yml

For sudo you will need to add your sudo password in the field *ansible_sudo_pass*


## Install oc-mirror clone, build, deploy, oc-mirror binary

Execute the following playbooks (in the given order)

### Install golang (if needed) and then clone and build oc-mirror

```
ansible-playbook golang.yml -i inventories/remotes 
ansible-playbook oc-mirror.yml -i inventories/remotes 
```

## Install mirror-registry

Execute the following playbooks (in the given order)

This will download and install the latest version of the mirror-registry, and finally install a rootCA to avoid problems with x509 self signed certificates


```
ansible-playbook mirror-registry.yml -i inventories/remotes 
ansible-playbook certs.yml -i inventories/remotes 
```

If you are still having problems with the x509 self signed cert error, try stopping and restarting the quay-app by ssh'ing into the remote server
and executing the following command

```
sudo systemctl restart quay-app
```

If the error still persists try installing the ssl certs and rootCA manually following the instructions here  https://docs.redhat.com/en/documentation/red_hat_quay/3.12/html/manage_red_hat_quay/using-ssl-to-protect-quay#configuring-ssl-using-cli

### Pipeline script

I have included a simple pipeline script that includes all the ansible playbooks as indicated above

Execute it using the relevant step

```
./pipeline.sh 1
./pipeline.sh 2
# and so on
```
