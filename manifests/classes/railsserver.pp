class railsserver {
	include ruby
	
	package { "rails":
		ensure => "3.0.5",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "unicorn":
		provider => "gem",
		ensure => "present",
		require => Package["ruby1.8-dev"]
	}
	package { "i18n":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "activemodel":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "rack":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "rack-test":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "rack-mount":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "tzinfo":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "abstract":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "erubis":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "actionpack":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "arel":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "activerecord":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "activeresource":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "mime-types":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "polyglot":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "treetop":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "mail":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "actionmailer":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "rake":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "thor":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "railties":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
	package { "bundler":
		ensure => "present",
		provider => "gem",
		require => Package["rubygems1.8"]
	}
}