class cvs {
    package { "cvs":
        ensure => present
    }
    
    file { "/etc/xinetd.d/cvs-pserver":
        source  => "puppet:///modules/cvs/cvs-pserver",
        owner   => "root",
        group   => "root",
        mode    => "0644",
        backup  => false,
        require => Package["xinetd"],
        notify  => Service["xinetd"]
    }
}