node "media.virtual.dojo" {
    $mirror="http://ftp.au.debian.org/debian"
    include common   
    
    package { "smbclient":
        ensure => installed,
    }
}