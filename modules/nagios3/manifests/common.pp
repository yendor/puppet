class nagios3::common {
	package { "nsca": 
		ensure => absent
	}
    file { "/etc/send_nsca.cfg": 
		source => "puppet:///modules/nagios3/nsca/send_nsca.cfg"
		ensure => absent
	}
}