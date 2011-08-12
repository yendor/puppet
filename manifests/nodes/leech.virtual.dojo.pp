node "leech.virtual.dojo" {
	$mirror="http://ftp.au.debian.org/debian"
	include common

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
		bind_to_ip => $ipaddress,
		allow_from => "192.168.1.41",
		instance_name => "home"
	}

	# augeas { "root_partition_noatime":
	#     context => "/files/etc/fstab",
	#     changes => "set *[file = '/']/opt errors=remount-ro,noatime,nodiratime",
	# }
}