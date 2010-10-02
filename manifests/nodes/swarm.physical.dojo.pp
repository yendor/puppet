node "swarm.physical.dojo" {
    $mirror="http://ftp.au.debian.org/debian"
    include common

    include virtual-machine-server

    virtual-machine::kvm { "puppet":
        ensure => present,
    }

    virtual-machine::kvm { "leech":
        ensure => absent,
        extra_args => "url=http://192.168.1.15/preseed.cfg"
    }
}