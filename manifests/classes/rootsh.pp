class rootsh {
    package { "rootsh":
        ensure => "present",
        require => File["/etc/apt/sources.list.d/interspire_custom.list"]
    }

    file { "/etc/apt/sources.list.d/interspire_custom.list":
        owner => root,
        group => root,
        mode => 0644,
    }

}