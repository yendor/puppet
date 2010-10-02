node "swarm.physical.dojo" {
    $mirror="http://ftp.au.debian.org/debian"
    include common

    include virtual-machine-server

    virtual-machine::kvm { "puppet":
        ensure => present,
    }

    virtual-machine::kvm { "leech":
        ensure => present,
        extra_args => "auto=true url=http://localhost/preseed.cfg"
    }
}