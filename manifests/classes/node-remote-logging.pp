class node-remote-logging {
	include wget, lenny-backports-keyring, sources-list, rsyslog::client

	host { "loghost":
		ensure => present,
		ip => "192.168.1.15",
	}
}
