node "puppetmaster.thedojo" {
    $mirror="http://ftp.au.debian.org/debian"
	include common
	include git

    dnsrecord {"login.thedojo":
        ensure => "present",
        type => "a",
        value => "192.168.1.12",
        ttl => 300,
    }

}
