base_dir := $(shell pwd)
terraform_values_path := $(shell echo $(base_dir)/terraform.tfvars)
build_folder_path := "./build"
dist_package_filename := "function.zip"
gcp_project_name := ""
gcp_region := ""

invoke-aws:
	aws lambda invoke \
		--function-name $(shell cd terraform ; terraform output -raw aws_function_name) \
		--payload $(shell cat events/aws_lambda.json| base64 ) out \
		--log-type Tail \
		--query 'LogResult' --output text |  base64 -d && \
		cat out | jq -r && rm -f out

invoke-gcp:
	gcloud functions call \
		$(shell cd terraform ; terraform output -raw gcp_function_name|cut -d "/" -f6) \
		--data '$(shell cat events/gcp_function.json)'	 \
		--project $(gcp_project_name) \
		--region $(gcp_region)

invoke-azure:
	curl --data '$(shell cat events/azure_function.json)' \
		$(shell cd terraform ; terraform output -raw azure_function_api_url)

invoke-all: invoke-aws invoke-gcp invoke-azure

.PHONY: build
build:
	@echo building && \
	if [ -d $(build_folder_path) ]; then rm -rf $(build_folder_path); fi && \
	mkdir $(build_folder_path) && \
	cp -r *.json *.py function $(build_folder_path)/ && \
	cd $(build_folder_path)/ && \
	cp gcp_handler.py main.py && \
	mkdir pythonmulticloud && \
	zip -r9 $(dist_package_filename) *.json *.py function/* && \
	cp -r *.json *.py function pythonmulticloud/ && \
	zip -r -g $(dist_package_filename) pythonmulticloud/

deploy-multicloud:
	@cd terraform && \
	terraform init && \
	terraform apply -var-file=$(terraform_values_path)

destroy-multicloud:
	@cd terraform && \
	terraform init && \
	terraform destroy -var-file=$(terraform_values_path)
