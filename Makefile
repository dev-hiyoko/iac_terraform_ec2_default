# init
init:
	@make git/commit-template
	chmod +x ./scripts/run-terraform.zsh

# terraform
terraform:
	@CMD=$(word 2, $(MAKECMDGOALS)) ; \
	SERVICE=$(word 3, $(MAKECMDGOALS)) ; \
	ENV=$(word 4, $(MAKECMDGOALS)) ; \
	zsh ./scripts/run-terraform.zsh $$CMD $$SERVICE $$ENV

# git
git/commit-template:
	git config commit.template ./.github/.gitmessage.txt &&\
	git config --add commit.cleanup strip
