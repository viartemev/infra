CWD := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

HAS_TF := $(shell terraform version 2>&1 | grep 'v1.')
ifndef HAS_TF
$(error  Install terraform version: v1.x)
endif

HAS_ANS := $(shell ansible --version 2>&1 | grep 'ansible 2.9')
ifndef HAS_TF
$(error  Install ansible version: 2.9)
endif

TF_DIR := $(CWD)/terraform


ANSIBLE_DIR := $(CWD)/ansible
ANSIBLE_CONFIG := $(ANSIBLE_DIR)/ansible.cfg

GITLAB_PROJECT_ID ?= 82
GITLAB_STATE_NAME ?= GitLab
GITLAB_USERNAME ?= varyumin
GITLAB_ACCESS_TOKEN ?= 7sJZyS4LUTzJNz6uGL32

export

.PHONY: help
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: terraform-init
terraform-init: ## terraform init
	cd '$(TF_DIR)' && \
	terraform init

.PHONY: terraform-get
terraform-get: ## terraform get -update
	@cd '$(TF_DIR)' && \
     terraform get -update

.PHONY: terraform-plan
terraform-plan: ## terraform plan
	@cd '$(TF_DIR)' && \
     terraform plan



.PHONY: terraform-apply
terraform-apply: ## terraform apply -auto-approve
	@cd '$(TF_DIR)' && \
     terraform apply -auto-approve

.PHONY: terraform-destroy
terraform-destroy: ## terraform destroy -auto-approve
	@cd '$(TF_DIR)' && \
     terraform destroy -auto-approve

.PHONY: terraform-output
terraform-output: ## terraform output -raw inventory
	@cd '$(TF_DIR)' && \
     terraform output -raw inventory > $(ANSIBLE_DIR)/inventory/inventory.ini

.PHONY: terraform
terraform:  terraform-init terraform-plan terraform-apply terraform-output ## terraform init plan and apply

.PHONY: priv-key-chmod
priv-key-chmod: ## chmod id_rsa
	@cd '$(ANSIBLE_DIR)' && \
     chmod 600 ssh/id_rsa

.PHONY: ansible-req
ansible-req: ## ansible-galaxy install requirements
	@cd '$(ANSIBLE_DIR)' && \
     ansible-galaxy install -r requirements.yaml

.PHONY: ansible-playbook
ansible-playbook: ## ansible-playbook run
	@cd '$(ANSIBLE_DIR)' && \
     ansible-playbook -i inventory/inventory.ini playbooks/install.yaml -b

.PHONY: ansible
ansible:  priv-key-chmod ansible-req ansible-playbook ## ansible run

.PHONY: install
install:  terraform ansible

