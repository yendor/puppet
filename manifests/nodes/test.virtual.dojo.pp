node "test.virtual.dojo" {
	$mirror="http://ftp.au.debian.org/debian"
	$includeBackports=true
	include common
	include logstash
	include dotdeb

	class { "nagios::node":
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

	# package { "nginx":
	# 	ensure => "1.0.1-1~dotdeb.0"
	# }
	#
	# package { "php5-fpm":
	# 	ensure => "5.3.6-6~dotdeb.0"
	# }
	package { "nginx":
		ensure => absent
	}
	package { "php5-fpm":
		ensure => absent
	}
}