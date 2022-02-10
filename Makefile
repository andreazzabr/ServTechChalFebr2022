C_GREEN ?= \e[32m
C_RESET ?= \e[0m
DOCKERTF = docker-compose run --rm tf
DOCKERAWS = docker-compose run --rm aws


init:
	$(DOCKERTF) init \
	-backend-config="bucket=$(TF_BACKEND_BUCKET)" \
    -backend-config="key=$(TF_BACKEND_KEY)"
	$(DOCKERTF) validate
.PHONY: init


plan_infra: init
	$(DOCKERTF) plan -target module.infra -out ./infra.plan
.PHONY: plan_infra


apply_infra: init
	$(DOCKERTF) apply ./infra.plan
	@echo "${C_GREEN}Infra is Ready ${C_RESET}"
.PHONY: apply_infra


prep_db: init
	$(DOCKERTF) plan -var tasktemplate=cdprep.json -out ./db.plan
	$(DOCKERTF) apply ./db.plan
	@echo "${C_GREEN} Preparing database, please wait... ${C_RESET}"
	sleep 90
	$(DOCKERTF) plan -target module.ecsservice -out ./db.plan -destroy
	$(DOCKERTF) apply ./db.plan
.PHONY: prep_db


serve: init
	$(DOCKERTF) plan -target module.ecsservice -out ./serve.plan -destroy
	$(DOCKERTF) apply ./serve.plan
	$(DOCKERTF) plan -target module.ecsservice -out ./serve.plan
	$(DOCKERTF) apply ./serve.plan
.PHONY: serve


dnsname:
	@echo "${C_GREEN} Please open your browser and visit:"
	@$(DOCKERAWS) elbv2 describe-load-balancers --name srvntchall-alb | grep DNSName
	@echo "${C_RESET}"
.PHONY: dnsname


destroy: init
	$(DOCKERTF) destroy -auto-approve
.PHONY: destroy


