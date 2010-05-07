class deb-build {
    package { "dh-make":
        ensure => "present"
    }

    package { "devscripts":
        ensure => "present"
    }

    package { "fakeroot":
        ensure => "present",
    }

    package { "quilt":
        ensure => "present",
    }

    package { "autotools-dev":
        ensure => "present",
    }
}
