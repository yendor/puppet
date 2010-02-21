class common {
    include vim, bash, ssh, less, rsync, apticron, logcheck, mail::aliases, clear-apt-cache

	include user::unixadmins
}
