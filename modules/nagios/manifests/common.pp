class nagios::common {
	package { "nsca": 
		ensure => present
	}
    file { "/etc/send_nsca.cfg": 
		source => "puppet:///modules/nagios/send_nsca.cfg"
	}
}