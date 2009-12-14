class stunnel-client {
	include stunnel

	file { "/etc/stunnel/stunnel.conf":
		owner => "root",
		group => "root",
		mode => "600",
		source => "puppet://puppet/files/etc/stunnel/stunnel-client.conf",
		notify => Exec["reload-stunnel"]
	}

	file { "/etc/default/stunnel4":
		owner => "root",
		group => "root",
		mode => "644",
		source => "puppet://puppet/files/etc/default/stunnel4",
		notify => Exec["reload-stunnel"]
	}

}
