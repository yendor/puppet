class avahi {
	package { "avahi-daemon":
		ensure => absent
	}

	file { "/etc/network/if-up.d/avahi-daemon":
	    mode => 0000
	}
}
