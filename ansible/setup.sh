#!/bin/bash

set -euxo pipefail

ANSIBLE_USER=lzuccarelli
PROJECT_DIR=Projects
ANSIBLE_SUDO_PASSWORD=<sudo-password>
# sed needs to escape /
USER_DIR="\/home\/lzuccarelli"

# sed each file with the values set above

# certs
sed -i "s/ansible_user: [a-zA-Z]*/ansible_user: ${ANSIBLE_USER}/g" roles/certs/vars/server.yml
sed -i "s/projects_dir: [a-zA-Z]*/projects_dir: ${PROJECT_DIR}/g" roles/certs/vars/server.yml
sed -i "s/user_dir: [a-zA-Z\/]*/user_dir: ${USER_DIR}/g" roles/certs/vars/server.yml
# add relevant special chars for your password 
sed -i "s/ansible_sudo_pass: [a-zA-Z\*\!]*/ansible_sudo_pass: ${ANSIBLE_SUDO_PASSWORD}/g" roles/certs/vars/server.yml

# golang
sed -i "s/ansible_user: [a-zA-Z]*/ansible_user: ${ANSIBLE_USER}/g" roles/golang/vars/main.yml
sed -i "s/projects_dir: [a-zA-Z]*/projects_dir: ${PROJECT_DIR}/g" roles/golang/vars/main.yml
sed -i "s/user_dir: [a-zA-Z\/]*/user_dir: ${USER_DIR}/g" roles/golang/vars/main.yml
# add relevant special chars for your password 
sed -i "s/ansible_sudo_pass: [a-zA-Z\*\!]*/ansible_sudo_pass: ${ANSIBLE_SUDO_PASSWORD}/g" roles/golang/vars/main.yml

# mirror-registry
sed -i "s/ansible_user: [a-zA-Z]*/ansible_user: ${ANSIBLE_USER}/g" roles/mirror-registry/vars/main.yml
sed -i "s/projects_dir: [a-zA-Z]*/projects_dir: ${PROJECT_DIR}/g" roles/mirror-registry/vars/main.yml
sed -i "s/user_dir: [a-zA-Z\/]*/user_dir: ${USER_DIR}/g" roles/mirror-registry/vars/main.yml
sed -i "s/ansible_sudo_pass: [a-zA-Z\*\!]*/ansible_sudo_pass: ${ANSIBLE_SUDO_PASSWORD}/g" roles/mirror-registry/vars/main.yml

# oc-mirror
sed -i "s/ansible_user: [a-zA-Z]*/ansible_user: ${ANSIBLE_USER}/g" roles/oc-mirror/vars/main.yml
sed -i "s/projects_dir: [a-zA-Z]*/projects_dir: ${PROJECT_DIR}/g" roles/oc-mirror/vars/main.yml
sed -i "s/user_dir: [a-zA-Z\/]*/user_dir: ${USER_DIR}/g" roles/oc-mirror/vars/main.yml
sed -i "s/ansible_sudo_pass: [a-zA-Z\*\!]*/ansible_sudo_pass: ${ANSIBLE_SUDO_PASSWORD}/g" roles/oc-mirror/vars/main.yml

# rust role
sed -i "s/ansible_user: [a-zA-Z]*/ansible_user: ${ANSIBLE_USER}/g" roles/rust/vars/main.yml
sed -i "s/projects_dir: [a-zA-Z]*/projects_dir: ${PROJECT_DIR}/g" roles/rust/vars/main.yml


