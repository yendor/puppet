class rsyslog {
	package { "rsyslog":
		ensure => present
	}
	package { "rsyslog-relp":
		ensure => present
	}
	exec { "reload-rsyslog":
		command => "/usr/sbin/invoke-rc.d rsyslog restart",
		refreshonly => true,
	}
}
