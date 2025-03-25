#!/bin/sh

export PS1="(nix config)$ "

config() {
	code -n -w configuration.nix
	sudo cp configuration.nix /etc/nixos/configuration.nix
	nixos-rebuild test --use-remote-sudo
}

alias upgrade="nixos-rebuild switch --upgrade"

commit() {
	git stage configuration.nix
	git commit -m "Update configuration"
	git push
	nixos-rebuild boot
}

sync() {
	cp /etc/nixos/configuration.nix configuration.nix
}

rsync() {
	sudo cp configuration.nix /etc/nixos/configuration.nix
}

alias nixdiff="diff configuration.nix /etc/nixos/configuration.nix"

rollback() {
	nix-env --rollback	
	sync
}
