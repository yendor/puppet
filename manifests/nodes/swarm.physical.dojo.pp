node "swarm.physical.dojo" {
    $mirror="http://ftp.au.debian.org/debian"
    include common

    include virtual-server

     virtual-machine::kvm { "puppet":
        ensure => present,
        vg => "vg01"
    }
}