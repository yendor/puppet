class rsyslog::midpoint {
	include rsyslog
	file { "/var/spool/rsyslog":
		mode => 700,
		owner => "root",
		group => "root",
		ensure => directory,
		require => Package["rsyslog"],
	}
	file { "/etc/rsyslog.d/midpoint.conf":
		owner => "root",
		group => "root",
		mode => 600,
		source => "puppet:///files/etc/rsyslog.d/midpoint.conf",
		require => Package["rsyslog"],
		notify => Exec["reload-rsyslog"],
	}
}


