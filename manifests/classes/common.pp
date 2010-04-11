class common {
#	include shared-hosts
    include vim, bash, ssh, less, rsync, apticron, logcheck, mail::aliases, clear-apt-cache, avahi, sudo, htop

	$includeBackports=true
	include sources-list, backports-keyring

	include user::unixadmins
}
