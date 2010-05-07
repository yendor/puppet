class rootsh {
    package { "rootsh":
        ensure => "present",
    }

    shells { "/usr/bin/rootsh":
        ensure => present
    }
}