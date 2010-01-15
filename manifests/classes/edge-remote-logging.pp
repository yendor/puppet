class edge-remote-logging {
	include wget, backports-keyring, sources-list, rsyslog::edge

	host { "loghost":
		ensure => present,
		ip => "192.168.1.15",
	}
}
