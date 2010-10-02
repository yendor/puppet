class tinydns::setup {
    exec { "rebuild-tinydns-data":
        cwd => "/etc/tinydns/root",
        command => "/usr/bin/make",
        refreshonly => true,
        require => [Package["djbdns"], Exec["tinydns-setup"], Exec["dnscache-setup"]],
        notify => Service["dnscache"]
    }

    exec { "tinydns-setup":
        command => "/usr/bin/tinydns-conf tinydns dnslog /etc/tinydns 127.0.0.1",
        creates => "/etc/tinydns",
        require => Package["djbdns"]
    }

    exec { "dnscache-setup":
        command => "/usr/bin/dnscache-conf dnscache dnslog /etc/dnscache $ipaddress",
        creates => "/etc/dnscache",
        require => Package["djbdns"]
    }

    user { "tinydns":
        ensure => present,
        comment => "Tinydns User",
        home => "/dev/null",
        shell => "/bin/false",
        uid => 30000,
    }

    user { "dnscache":
        ensure => present,
        comment => "Dnscache User",
        home => "/dev/null",
        shell => "/bin/false",
        uid => 30001,
    }

    user { "dnslog":
        ensure => present,
        comment => "Djbdns Log User",
        home => "/dev/null",
        shell => "/bin/false",
        uid => 30002,
    }

    package { "djbdns":
        ensure => "present"
    }

    package { "make":
        ensure => "present"
    }

    file { "/etc/service/tinydns":
        ensure => "/etc/tinydns",
        require => [Exec["tinydns-setup"], Exec["dnscache-setup"]]
    }

    file { "/etc/service/dnscache":
        ensure => "/etc/dnscache",
        require => [Exec["tinydns-setup"], Exec["dnscache-setup"]]
    }

    file { "/etc/dnscache/root/servers/$domain":
        content => "127.0.0.1"
    }

    service { "dnscache":
        provider => "daemontools",
        path => "/etc/dnscache";
    }

    service { "tinydns":
        provider => "daemontools",
        path => "/etc/dnscache";
    }
}