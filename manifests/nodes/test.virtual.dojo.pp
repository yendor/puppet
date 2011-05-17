node "test.virtual.dojo" {
	$mirror="http://ftp.au.debian.org/debian"
	$includeBackports=true
	include common
	# include puppetmaster
	# include kvm::server
	include logstash
	include dotdeb

	class { "nagios:common": }

	class { "nagios::server":
		instance_name = 'home'
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

	package { "nginx":
		ensure => "1.0.1-1~dotdeb.0"
	}

	package { "php5-fpm":
		ensure => "5.3.6-6~dotdeb.0"
	}
}