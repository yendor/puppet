class airvideoserver::setup($runasuser, $jarpath, $proppath)
{
    file { "/etc/init.d/airvideoserver":
        ensure => file,
        source => "puppet:///modules/airvideoserver/airvideoserver.init",
        mode   => 0755,
        owner  => root,
        group  => root,
        backup => false,
    }
    
    file { "/etc/default/airvideoserver":
        ensure  => file,
        mode    => 0755,
        owner   => root,
        group   => root,
        content => template("airvideoserver/defaults.erb"),
        backup  => false,
    }
    
    file { "/var/run/airvideoserver":
        ensure => directory,
        owner  => $runasuser,
        backup => false,
        mode   => 0755,
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

     package { "pkg-config":
         ensure => installed,
     }

     package { "openjdk-6-jdk":
         ensure => installed,
     }
    
}