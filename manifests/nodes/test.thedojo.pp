node "test.thedojo" {
    $mirror="http://ftp.au.debian.org/debian"
	include common
	include edge-remote-logging

	include fail2ban
	include user::unixadmins
}

