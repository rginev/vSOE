# Default goal if make is executed without arguments
.DEFAULT_GOAL := validate

.PHONY: init
init: # Installs basic utilities required for the rest of the tasks
	@echo "Installing required utilities"
	@sudo ./bootstrap.sh

.PHONY: validate
validate: # Validates ansible playbooks
	@echo "Linting Ansible code"
	@ansible-lint -v --exclude="./playbooks/roles/vim/files/dot_vim/pack" `find . -name "*.yml"`

.PHONY: dryrun
dryrun: # ansible playbook dryrun
	@echo "Running ansible playbook in check mode"
	@cd playbooks; ansible-playbook -vvvvv --check --diff  setup.yml; cd -

.PHONY: play
play: # run ansible playbook
	@echo "Running ansible playbook"
	@cd playbooks; ansible-playbook -vvv setup.yml; cd -

