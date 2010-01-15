class rsyslog::edge {
	include rsyslog
	file { "/var/spool/rsyslog":
		mode => 700,
		owner => "root",
		group => "root",
		ensure => directory,
		require => Package["rsyslog"],
	}
	file { "/etc/rsyslog.d/edge.conf":
		owner => "root",
		group => "root",
		mode => 600,
		source => "puppet://puppet/files/etc/rsyslog.d/edge.conf",
		require => Package["rsyslog"],
		notify => Exec["reload-rsyslog"],
	}
}


