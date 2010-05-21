class edge-remote-logging {
	include wget, backports-keyring, sources-list

	host { "loghost":
		ensure => absent,
		ip => "192.168.1.15",
	}
}
