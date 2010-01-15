node "puppetmaster.thedojo" {
    $mirror="http://ftp.au.debian.org/debian"
	include common
	include midpoint-remote-logging
}


