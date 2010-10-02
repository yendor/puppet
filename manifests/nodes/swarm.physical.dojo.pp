node "swarm.physical.dojo" {
    $mirror="http://ftp.au.debian.org/debian"
    include common

    include virtual-machine-server

     virtual-machine::kvm { "puppet":
        ensure => present,
    }
}