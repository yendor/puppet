node "media.virtual.dojo" {
    $mirror="http://ftp.au.debian.org/debian"
    include common   

    package { "smbclient":
        ensure => installed,
    }

    include bzip2
    
    package { "make":
        ensure => installed,
    }
    
    package { "checkinstall":
        ensure => installed,
    }
    
    package { "yasm":
        ensure => installed,
    }
    
    package { "git-core":
        ensure => installed,
    }
    
    package { "x264":
        ensure => absent,
    }
    
    file { "/etc/apt/sources.list.d/multimedia.list":
        ensure  => file,
        content => "deb http://debian.netcologne.de/debian-multimedia.org stable main",
        owner   => root,
        group   => root,
        mode    => 0644,
        notify  => Exec["update-packgelist"]
    }
    
    package { "libx264-dev":
        ensure => installed,
        require => File["/etc/apt/sources.list.d/multimedia.list"]
    }
    
    package { "libmp3lame-dev":
        ensure => installed,
        require => File["/etc/apt/sources.list.d/multimedia.list"]
    }
    
    package { "libfaad-dev":
        ensure => installed,
        require => File["/etc/apt/sources.list.d/multimedia.list"]
    }
    
    package { "mpeg4ip-server":
        ensure => installed,
        require => File["/etc/apt/sources.list.d/multimedia.list"]
    }
    
    package { "pkg-config":
        ensure => installed,
    }
    
    package { "openjdk-6-jdk":
        ensure => installed,
    }
}