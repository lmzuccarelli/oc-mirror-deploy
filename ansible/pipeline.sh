#!/bin/bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage   : pipeline.sh <step>"
  echo "Example : pipeline.sh 1"
  exit 0
fi

case "${1}" in 
    1)
      echo "remote install of golang"
      ansible-playbook golang.yml -i inventories/remotes 
      ;;
    2)
      echo "remote install of oc-mirror"
      ansible-playbook oc-mirror.yml -i inventories/remotes
    ;;
    3)
      echo "remote install of mirror-registry and certs"
      ansible-playbook mirror-registry.yml -i inventories/remotes
      sleep 5;
      ansible-playbook certs.yml -i inventories/remotes
    ;;
esac
