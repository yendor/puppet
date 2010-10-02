class tinydns::setup {
    exec { "rebuild-tinydns-data":
        cwd => "/etc/tinydns/root",
        command => "/usr/bin/make",
        refreshonly => true,
        require => Package["djbdns"]
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
        uid => 100,
    }

    user { "dnscache":
        ensure => present,
        comment => "Tinydns User",
        home => "/dev/null",
        shell => "/bin/false",
        uid => 101,
    }

    user { "dnslog":
        ensure => present,
        comment => "Tinydns User",
        home => "/dev/null",
        shell => "/bin/false",
        uid => 102,
    }

    package { "djbdns":
        ensure => "present"
    }

    package { "make":
        ensure => "present"
    }
}