class rsyslog::client {
	file { "/var/spool/rsyslog":
		mode => 700,
		owner => "root",
		group => "root",
		ensure => directory,
		require => Package["rsyslog"],
	}
	file { "/etc/rsyslog.d/remote.conf":
		owner => "root",
		group => "root",
		mode => 700,
		source => "puppet://puppet/files/etc/rsyslog.d/remote.conf",
		require => Package["rsyslog"],
		notify => Exec["reload-rsyslog"],
	}
}


