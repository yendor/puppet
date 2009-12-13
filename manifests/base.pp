node basenode {
	include vim, bash, ssh, less, rsync, apticron, logcheck, mail::aliases
}

node xennode inherits basenode {
	include xen-tools
}

