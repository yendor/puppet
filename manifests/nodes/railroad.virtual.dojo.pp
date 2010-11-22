node "railroad.virtual.dojo" {
  $mirror="http://ftp.au.debian.org/debian"
  include common

	package { "rubygems1.8":
		ensure => "1.3.4-1~bpo50+1"
	}

	# package { "rails":
	# 	ensure => "3.0.3",
	# 	provider => "gem"
	# }
}