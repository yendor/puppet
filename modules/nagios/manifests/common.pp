class nagios::common {
	package { "nsca": 
		ensure => present
	}
    rfile { "/etc/send_nsca.cfg": 
		source => "/nsca/send_nsca.cfg"
	}
}