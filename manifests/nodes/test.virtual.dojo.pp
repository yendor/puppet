node "test.virtual.dojo" {
	$mirror="http://ftp.au.debian.org/debian"
	$includeBackports=true
	include common
	# include puppetmaster

	# include kvm::server
	disk::scheduler{ "vda":
		scheduler => "noop"
	}

	disk::readahead { "vda":
		size => "2048"
	}

	# augeas { "root_partition_noatime":
	#     context => "/files/etc/fstab",
	#     changes => "set *[file = '/']/opt errors=remount-ro,noatime,nodiratime",
	# }

}