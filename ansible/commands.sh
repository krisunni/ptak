#!/bin/bash

# Disable host key checking for Ansible connections
export ANSIBLE_HOST_KEY_CHECKING=False

# Use Ansible to ping all hosts in the inventory using the ubuntu user
ansible -i hosts.txt all -u ubuntu -m ping

# Run Ansible playbook to install Kubernetes dependencies on all hosts
ansible-playbook -i hosts.txt install-kube-deps.yml

# Run Ansible playbook to initialize the Kubernetes cluster on all hosts
ansible-playbook -i hosts.txt init-cluster.yml

# Run Ansible playbook to generate and retrieve the join command for adding nodes to the cluster
ansible-playbook -i hosts.txt join-command.yml

# Run Ansible playbook to join agent nodes to the Kubernetes cluster using the join command
ansible-playbook -i hosts.txt join-agents.yml
