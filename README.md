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

Optionally you could execute the *setup.sh* script that will update all the var files using sed, add and update as you see fit


## Install oc-mirror binary

Execute the following playbooks (in the given order)

**NB** There is a dependency to install gpgme-devel (Fedora specific). Change this to comply with the linux distribution package manager thats appropriate.

### Install golang (if needed) and then clone and build oc-mirror

```
ansible-playbook golang.yml -i inventories/remotes 
ansible-playbook oc-mirror.yml -i inventories/remotes 
```

This has been tested on Fedora 40 and Rhel9 

## Install mirror-registry

Before starting ensure the ip address and hostname are set (etc/hosts), also update the playbook vars file with the server name and ip

Execute the following playbook

This will download and install the latest version of the mirror-registry, and finally install a rootCA to avoid problems with x509 self signed certificates

**NB** the certs playbook is no longer needed. I found that by copying the already created rootCA to
the containers directory and to the trusted wide store this works.

Use the certs playbook for more customization, it still gives a startup error (quay-app) with
*ssl.cert is required for HostSettings* - this is still a WIP

```
ansible-playbook mirror-registry.yml -i inventories/remotes 
```

In the final display take not of the line credentails (init,xxx) - where xxx is the password, you will need it to login into Podman to create the auth.json

If you are still having problems with the x509 self signed cert error, try stopping and restarting the quay-app by ssh'ing into the remote server
and executing the following command

```
sudo systemctl restart quay-app
```

If the error still persists try installing the ssl certs and rootCA manually following the instructions here  https://docs.redhat.com/en/documentation/red_hat_quay/3.12/html/manage_red_hat_quay/using-ssl-to-protect-quay#configuring-ssl-using-cli


## Final setup checklist 

Once logged into the quay mirror-registry (using podman to generate auth.json file found in $XDG_RUNTIME_DIR/containers/), 
merge this with your main auth.json file, obtained from pull secrets found at https://console.redhat.com/openshift/install/pull-secret).
i.e you could try something like this

```
podman login <server_name>:8443 --authfile $XDG_RUNTIME_DIR/containers/auth.json --tls-verify=false
```

The ansible playbook does not set /etc/hosts - this will need to added manually to resolve host names.

Remember to copy the rootCA cert from the remote mirror-registry machine to the base machine (that will be executing the oc-mirror binary).
The script does a fetch, push and copy of the rootCA, but it hasn't been verified.
