class dotdeb {
	file { "/etc/apt/sources.list.d/dotdeb.conf":
		source => $lsbdistcodename ? {
			'lenny' => "puppet:///files/dotdeb/lenny.conf"
		}, 
		owner => "root",
		group => "root",
		mode => 0644,
		require => File["/etc/apt/keys/dotdeb.gpg"],
		notify => Exec["apt-update"],
	}
	
	file { "/etc/apt/keys": 
		ensure => directory,
		mode => 0700,
	}
	
	file { "/etc/apt/keys/dotdeb.gpg":
		source => "puppet:///files/dotdeb/dotdeb.gpg",
		owner => "root",
		group => "root",
		mode => 0600,		
		notify => Exec["apt-key-add"],
	}
	
	exec { "apt-key-add":
		command => "/usr/bin/apt-key add /etc/apt/keys/dotdot.gpg",
		require => File["/etc/apt/keys/dotdot.gpg"],
		refreshonly => true,
	}
	
	exec { "apt-update":
		command => "/usr/bin/apt-get update", 
		refreshonly=> true,
	}
	
}