node "recordkeeper.thedojo" {
  $mirror="http://ftp.au.debian.org/debian"
	$includeBackports = true

	include common
	include sources-list, backports-keyring

	include fail2ban
}


