# init
.PHONY: init
init: git/commit-template
	chmod +x ./scripts/run-terraform.zsh

# terraform
# TODO 引数でterraform用の引数を渡せない
.PHONY: terraform
terraform:
	@SERVICE=$(word 2, $(MAKECMDGOALS)) ; \
	ENV=$(word 3, $(MAKECMDGOALS)) ; \
	CMD=$(word 4, $(MAKECMDGOALS)) ; \
	EXTRA=$(MAKEFLAGS) ; \
	zsh ./scripts/run-terraform.zsh $$SERVICE $$ENV $$CMD $(EXTRA)

# git
git/commit-template:
	git config commit.template ./.github/.gitmessage.txt &&\
	git config commit.cleanup strip
