node "swarm.physical.dojo" {
    $mirror="http://ftp.au.debian.org/debian"
    include common

    include virtual-machine-server

    virtual-machine::kvm { "puppet":
        ensure => present,
    }

    virtual-machine::kvm { "leech":
        ensure => present,
        extra_args => "auto=true url=http://192.168.1.10/preseed.cfg"
    }

    virtual-machine::kvm { "test":
        ensure => present,
        extra_args => "auto=true url=http://192.168.1.10/preseed.cfg"
    }

    virtual-machine::kvm { "railroad":
        ensure => present,
        extra_args => "auto=true url=http://192.168.1.10/preseed.cfg"
    }

    virtual-machine::kvm { "squeeze":
        ensure => present,
        extra_args => "auto=true url=http://192.168.1.10/preseed-squeeze.cfg",
		iso => "http://ftp.nl.debian.org/debian/dists/testing/main/installer-amd64/current/images/"
    }
}