class midpoint-remote-logging {
	include wget, backports-keyring, sources-list, rsyslog::midpoint

	host { "loghost":
		ensure => present,
		ip => "192.168.1.18",
	}
}
