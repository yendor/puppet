node "test" {
    $mirror="http://ftp.au.debian.org/debian"
	include common
	include edge-remote-logging

	include fail2ban
}

