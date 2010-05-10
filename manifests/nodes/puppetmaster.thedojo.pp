node "puppetmaster.thedojo" {
    $mirror="http://ftp.au.debian.org/debian"
	include common
	include midpoint-remote-logging
	include git

    dnsrecord {"login.thedojo":
        type => "a",
        value => "192.168.1.12",
        ttl => 300,
    }

}
