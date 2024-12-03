# git
git/commit-template:
	git config commit.template ./.github/.gitmessage.txt &&\
	git config --add commit.cleanup strip
