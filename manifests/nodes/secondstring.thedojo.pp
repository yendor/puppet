node "secondstring.thedojo" {
    $mirror="http://ftp.au.debian.org/debian"
	include common
	include edge-remote-logging

	$isPlesk=true
	include fail2ban

	include user::unixadmins
}

