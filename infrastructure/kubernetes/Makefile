default: plan

backend_instance_id := real-macaque
state_prefix := kubernetes

login:
	az login
	az account set --subscription "Jim Counts (Personal)"
	az account show --output table

backend_config:
	az keyvault secret download \
		--name azurerm-backend-tfvars \
		--vault-name kv-$(backend_instance_id) \
		--file azurerm.backend.tfvars

	sed -i \
		's/istio-azure-sql.tfstate/$(state_prefix).tfstate/' \
		azurerm.backend.tfvars

fmt:
	terraform fmt -recursive

init:
	terraform init --upgrade -backend-config azurerm.backend.tfvars
	terraform -v
	terraform providers
	
clean:
	terraform destroy -auto-approve

config:
	@echo 'backend_instance_id="$(backend_instance_id)"' > terraform.auto.tfvars

validate:
	terraform validate

plan: config init fmt validate
	terraform plan -out plan.tfplan

apply: 
	terraform apply plan.tfplan
	rm plan.tfplan
