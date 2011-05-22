node "test.virtual.dojo" {
	$mirror="http://ftp.au.debian.org/debian"
	$includeBackports=true
	include common
	include logstash
	include dotdeb

	nagios3::host { $fqdn:
		instance_name => "home",
		address => $ipaddress,
		host_name => $fqdn,
		host_alias => $hostname,
		contact_groups => "admins"
	}

	class { "internal-nagios-server":
		instance_name => "home"
	}
	
	class { "web-monitoring":
		instance_name => "home",
		host_name => $fqdn,
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

	disk::scheduler{ "vda":
		scheduler => "noop"
	}

	disk::readahead { "vda":
	}

	# augeas { "root_partition_noatime":
	#     context => "/files/etc/fstab",
	#     changes => "set *[file = '/']/opt errors=remount-ro,noatime,nodiratime",
	# }
	
	class { "drobo-monitoring": }

}