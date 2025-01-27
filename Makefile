# init
.PHONY: init
init: git/commit-template
	chmod +x ./scripts/run-terraform.zsh



# terraform
# TODO 引数でterraform用の引数を渡せない
.PHONY: terraform
terraform:
	@SERVICE=$(word 2, $(MAKECMDGOALS)); \
	 ENV=$(word 3, $(MAKECMDGOALS)); \
	 COMMAND=$(word 4, $(MAKECMDGOALS)); \
	 EXTRA="$(wordlist 5, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))"; \
	 ./scripts/run-terraform.zsh $$SERVICE $$ENV $$COMMAND $$EXTRA

# git
git/commit-template:
	git config commit.template ./.github/.gitmessage.txt &&\
	git config commit.cleanup strip

%:
	@:
