# Needed SHELL since I'm using zsh
SHELL := /bin/bash
.PHONY: help

help: ## This help dialog.
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

destroy: ## Shutdown vagrant environment and purge files.
	vagrant destroy -f
	@rm -rf .vagrant

tfs-rdp:  ## Access TFS server via xfreerdp
	@xfreerdp /cert:ignore /v:192.168.50.10 /u:vagrant /p:vagrant /t:tfs-server

tfs-reboot: ## Reboot TFS Server
	vagrant winrm -e -c "Restart-Computer -Force" tfs

tfs-nmap: ## Check Open Ports on TFS server with nmap
	nmap 192.168.50.10 -Pn -p 3389,5985,5986

db-shell: ## Shell into DB Server
	vagrant ssh db

