node "recordkeeper.thedojo" {
    $mirror="http://ftp.au.debian.org/debian"
	$includeBackports = true

	include common
	include rsyslog::loghost, sources-list, backports-keyring
}


