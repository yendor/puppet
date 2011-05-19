node "leech.virtual.dojo" {
	$mirror="http://ftp.au.debian.org/debian"
	include common

	include transmission

	class { "nagios::node":
		instance_name => "home",
		address => $ipaddress,
		host_name => $fqdn,
		host_alias => $hostname,
		contact_groups => "admins"
	}

	# class { "ssh-monitoring":
	# 	instance_name => "home",
	# }

	# augeas { "root_partition_noatime":
	#     context => "/files/etc/fstab",
	#     changes => "set *[file = '/']/opt errors=remount-ro,noatime,nodiratime",
	# }
}