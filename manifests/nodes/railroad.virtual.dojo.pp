node "railroad.virtual.dojo" {
  $mirror="http://ftp.au.debian.org/debian"
  include common

	package { "rubygems1.8":
		ensure => "1.3.7-3"
	}
	
	package { "rails":
		ensure => "3.0.3",
		provider => "gem"
	}
}