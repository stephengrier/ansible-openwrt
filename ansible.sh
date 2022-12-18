#!/bin/ash
cd /ansible
ansible-galaxy install -r requirements.yml
ansible-playbook -k openwrt.yml
