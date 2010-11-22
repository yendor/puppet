node "railroad.virtual.dojo" {
  $mirror="http://ftp.au.debian.org/debian"
  include common

	include railsserver
	
	include nginx
	
	nginx::site{ "nessus":
		ensure => present
	}
}