node "puppetmaster.thedojo" {
    $mirror="http://ftp.au.debian.org/debian"
	include common
	include midpoint-remote-logging
	include git

	include tinydns


    $tinydns = "/etc/tinydns"

    # we have no slave servers
    $slaves = []

    # we're authoritative for these zones
    $zones = [
        "thedojo"
    ]

    # set up the server
    tinydns::server { "tinydns":
        directory => $tinydns,
        listen_address => "127.0.0.1",
        ensure => present
    }

    # we're master
    tinydns::master { "tinydns":
        directory => $tinydns,
        slaves => $slaves,
        zones => $zones,
        ensure => present
    }

    $dnscache = "/etc/dnscache"
    $dnscache_root = "$dnscache/root"

    # set up the cache itself
    tinydns::cache { "dnscache":
        directory => $dnscache,
        listen_address => "192.168.1.15",
        ensure => present
    }

    # do we want to forward for any zones?
    $fwd_zones = [
        "$dnscache_root/servers/thedojo",
    ]

    # set up the forwarding and tell dnscache where to forward to
    tinydns::forwardzone { $fwd_zones:
        service => "dnscache", # must match the dnscache title above
        data => "127.0.0.1\n"
    }

    # allow some people to query the cache
    $allow_files = [
        "$dnscache_root/ip/127.0.0.1",
        "$dnscache_root/ip/192.168.1"
    ]

    # set up the allow files
    tinydns::cacheallow { $allow_files:
        service => "dnscache" # must match the dnscache title above
    }
}
