class transmission {
    package { "transmission-daemon":
        ensure => "1.77-1~bpo50+2"
    }

    service { "transmission-daemon":
        ensure => running,
        hasrestart => true,
        hasstatus => true
    }

    file { "/etc/transmission-daemon/settings.json":
        source => "puppet:///files/transmission/settings.json",
        owner => "root",
        group => "root",
        mode => "0644",
        notify => Service["transmission-daemon"],
        require => Package["transmission-daemon"]
    }
}