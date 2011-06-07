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
		bind_to_ip => $ipaddress,
		allow_from => "192.168.1.41",
		instance_name => "home"
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

    include iptables

	iptables { "115 create ratelimited custom chain":
        customchain => "RATELIMITED",
        table => "filter",
    }

    iptables { "zzzz - 1 Set a max rate limit to 30 pps average":
        raw_rule => "-A RATELIMITED -m limit --limit 30/sec --limit-burst 6 -j RETURN",
        table => "filter",
    }
    iptables { "zzzzz - 2 Drop traffic that exceeds the rate limit":
        raw_rule => "-A RATELIMITED -j DROP",
        table => "filter"
    }

    iptables { "115 create aardvark custom chain":
        customchain => "AARDVARK",
        table => "filter",
    }

    iptables { "zzzz - 1 Set a max aardvark rate limit to 30 pps average":
        raw_rule => "-A AARDVARK -m limit --limit 30/sec --limit-burst 6 -j RETURN",
        table => "filter",
    }
    iptables { "zzzzz - 2 Drop aardvark traffic that exceeds the rate limit":
        raw_rule => "-A AARDVARK -j DROP",
        table => "filter"
    }
    
    Iptables <<| |>>

	class { "drobo-monitoring": }

}