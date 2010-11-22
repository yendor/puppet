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
	
	package { "i18n":
		ensure => "present",
		provider => "gem"
	}
	package { "activemodel":
		ensure => "present",
		provider => "gem"
	}
	package { "rack":
		ensure => "present",
		provider => "gem"
	}
	package { "rack-test":
		ensure => "present",
		provider => "gem"
	}
	package { "rack-mount":
		ensure => "present",
		provider => "gem"
	}
	package { "tzinfo":
		ensure => "present",
		provider => "gem"
	}
	package { "abstract":
		ensure => "present",
		provider => "gem"
	}
	package { "erubis":
		ensure => "present",
		provider => "gem"
	}
	package { "actionpack":
		ensure => "present",
		provider => "gem"
	}
	package { "arel":
		ensure => "present",
		provider => "gem"
	}
	package { "activerecord":
		ensure => "present",
		provider => "gem"
	}
	package { "activeresource":
		ensure => "present",
		provider => "gem"
	}
	package { "mime-types":
		ensure => "present",
		provider => "gem"
	}
	package { "polyglot":
		ensure => "present",
		provider => "gem"
	}
	package { "treetop":
		ensure => "present",
		provider => "gem"
	}
	package { "mail":
		ensure => "present",
		provider => "gem"
	}
	package { "actionmailer":
		ensure => "present",
		provider => "gem"
	}
	package { "rake":
		ensure => "present",
		provider => "gem"
	}
	package { "thor":
		ensure => "present",
		provider => "gem"
	}
	package { "railties":
		ensure => "present",
		provider => "gem"
	}
	package { "bundler":
		ensure => "present",
		provider => "gem"
	}
}