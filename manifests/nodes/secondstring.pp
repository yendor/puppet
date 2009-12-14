node "secondstring" inherits xennode {
	$includeBackports = true
	$mirror = "http://ftp.iinet.net.au/debian/debian/"
	include rsyslog::client, rsyslog, lenny-backports-keyring, sources-list
}

