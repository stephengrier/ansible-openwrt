#!/bin/ash
cd /ansible
ansible-galaxy install -r requirements.yml
ansible-playbook -k --ask-vault-password openwrt.yml
