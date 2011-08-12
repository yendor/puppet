node "media.virtual.dojo" {
    $mirror="http://ftp.au.debian.org/debian"
    include common   

    package { "smbclient":
        ensure => installed,
    }

    class airvideoserver { 
        runasuser => "rodney.amato",
        jarpath   => "/home/rodney.amato/airvideo/AirVideoServerLinux.jar",
        proppath  => "/home/rodney.amato/airvideo/test.properties",
    } 
}