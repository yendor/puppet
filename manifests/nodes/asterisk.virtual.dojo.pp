node "asterisk.virtual.dojo" {
	$mirror="http://ftp.au.debian.org/debian"
	include common

	disk::scheduler("noop")

}