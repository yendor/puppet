class shared-hosts {
	@@host { "internal.$fqdn" :
		ensure => present,
		ip  => "$ipaddress_eth1",
	}
	Host <<| |>>
}
