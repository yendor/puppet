class avahi {
	package { "avahi-daemon": 
		ensure => absent
	}
}
