registry := crrealmacaque
repository := sqlworker

default: push

login:
	az login
	az account set --subscription "Jim Counts (Personal)"
	az account show --output table

info:
	az acr repository show-tags \
		--name ${registry} \
		--repository ${repository} \
		--orderby time_desc \
		--output table

push:
	az acr build \
		--image ${repository}:latest \
		--image ${repository}:{{.Run.ID}} \
		--registry ${registry} \
		--file Dockerfile .