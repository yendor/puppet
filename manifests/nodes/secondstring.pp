node "secondstring" {
    $mirror="http://ftp.au.debian.org/debian"
	include common
	include edge-remote-logging

	$isPlesk=true
	include fail2ban
}

