class rootsh {
    package { "rootsh":
        ensure => "present",
        require => File["/etc/apt/sources.list.d/interspire_custom.list"]
    }

}