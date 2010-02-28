node "puppetmaster.thedojo" {
	# Setup the sources.list
    $mirror="http://ftp.au.debian.org/debian"
	$includeBackports=true
	include sources-list, backports-keyring

	include common
	include midpoint-remote-logging

	include user::unixadmins
}


