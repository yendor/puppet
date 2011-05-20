node "leech.virtual.dojo" {
	$mirror="http://ftp.au.debian.org/debian"
	include common

	include transmission

	nagios::host { $fqdn:
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
	
	class { "transmission-monitoring":
		instance_name => "home",
		host_name => $fqdn,
	}

	# augeas { "root_partition_noatime":
	#     context => "/files/etc/fstab",
	#     changes => "set *[file = '/']/opt errors=remount-ro,noatime,nodiratime",
	# }
}