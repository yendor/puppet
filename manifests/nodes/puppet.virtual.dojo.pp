node "puppet.virtual.dojo" {
	 $mirror="http://ftp.au.debian.org/debian"
	 $storedconfig_db_user = "puppet"
	 $storedconfig_db_pass = "J2RL;wxG"
	 $storedconfig_db_name = "puppet"
	 $storedconfig_db_host = "localhost"

	 include common
	 include git
	 include tinydns::setup
	 include puppetmaster

	dnsrecord { "nameserver for thdojo":
		ensure => present,
		type => ".",
		fqdn => "virtual.dojo",
		ipaddr => "192.168.1.15",
		notify => Exec["rebuild-tinydns-data"]
	}

	dnsrecord { "reverse dns for 192.168.1.0/24 subnet":
		ensure => present,
		type => ".",
		fqdn => "1.168.192.in-addr.arpa",
		ipaddr => "192.168.1.15",
		notify => Exec["rebuild-tinydns-data"]
	}

	dnsrecord { "alias for login.virtual.dojo":
		ensure => present,
		type => "+",
		fqdn => "login.virtual.dojo",
		ipaddr => "192.168.1.12",
		notify => Exec["rebuild-tinydns-data"]
	}

	dnsrecord { "alias for the puppet.virtual.dojo dns entry":
		ensure => present,
		type => "+",
		fqdn => "puppet.virtual.dojo",
		ipaddr => "192.168.1.15",
		notify => Exec["rebuild-tinydns-data"]
	}

	dnsrecord { "txt record for virtual.dojo":
		ensure => present,
		fqdn => "virtual.dojo",
		type => "'",
		value => "v=spf1 a mx",
		notify => Exec["rebuild-tinydns-data"]
	}

	nagios3::host { $fqdn:
		instance_name => "home",
		address => $ipaddress,
		host_name => $fqdn,
		host_alias => $hostname,
		contact_groups => "admins"
	}

	class { "ssh-monitoring":
		instance_name => "home",
		host_name => $fqdn,
	}

	class { "nagios3::nrpe":
		bind_to_ip = $ipaddress,
		allow_from = "192.168.1.41",
		instance_name = "home"
	}

	Dnsrecord <<| |>>
}
