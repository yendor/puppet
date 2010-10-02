class transmission {
    package { "transmission-daemon":
        ensure => "1.77-1~bpo50+2"
    }

    service { "transmission-daemon":
        hasrestart => true,
        hasreload => true
    }

    file { "/etc/transmission-daemon/settings.json":
        source => "puppet:///files/transmission/settings.json",
        owner => "root",
        group => "root",
        mode => "0644",
    }
}