class nagios3::common {
	package { "nsca": 
		ensure => present
	}
    file { "/etc/send_nsca.cfg": 
		source => "puppet:///modules/nagios/nsca/send_nsca.cfg"
	}
}