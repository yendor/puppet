class puppetmaster {
    $puppet_version = "2.6.2-1~bpo50+1"
    package { "puppetmaster":
        ensure => $puppet_version,
        require => [File["/etc/default/puppetmaster"], Package["libapache2-mod-passenger"]]
    }
    
    package { "puppet-common":
        ensure => $puppet_version
    }
    
    package { "libapache2-mod-passenger":
        ensure => "2.2.11debian-1~bpo50+1",
        require => Package["apache2"]
    }
    
    package { "rails-ruby1.8":
        ensure => "2.3.5-1~bpo50+1",
        require => Package["libactiverecord-ruby1.8", "rake"]
    }
    
    package { "librack-ruby1.8":
        ensure => "1.1.0-4~bpo50+1"
    }
    
    package { "librack-ruby":
        ensure => "1.1.0-4~bpo50+1",
        require => Package["librack-ruby1.8"]
    }
    
    package { "rake":
        ensure => "0.8.7-1~bpo50+1"
    }
    
    package { "libactiverecord-ruby1.8":
        ensure => "2.3.5-1~bpo50+1",
        require => Package["libactivesupport-ruby1.8"]
    }
    
    package { "libactivesupport-ruby1.8":
        ensure => "2.3.5-1~bpo50+1",
        require => Package["librack-ruby"]
    }
    
    package { "libjs-jquery":
        ensure => "1.4.2-2~bpo50+1"
    }
    
    package { "libi18n-ruby1.8":
        ensure => "0.3.6-1~bpo50+1"
    }
    
    package { "libtzinfo-ruby1.8":
        ensure => "0.3.19-1~bpo50+1"
    }
    
    package { "libmemcache-client-ruby1.8":
        ensure => "1.7.8-1~bpo50+1"
    }
    
    package { "apache2":
        ensure => "present"
    }
    
    service { "apache2":
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Package["apache2"]
    }
    
    file { "/etc/apache2/sites-available/puppetmaster": 
        content => template("puppetmaster/apachehost-rack.erb"),
        backup => false
    }
    
    file { "/etc/apache2/sites-enabled/puppetmaster":
        ensure => "/etc/apache2/sites-available/puppetmaster",
        backup => false,
        require => [File["/etc/apache2/sites-available/puppetmaster"]],
        notify => Service["apache2"]
    }
    
    file { "/etc/apache2/mods-enabled/passenger.conf":
        ensure => "../mods-available/passenger.conf",
        backup => false,
        require => [Package["libapache2-mod-passenger"]],
        notify => Service["apache2"]
    }
    
    file { "/etc/apache2/mods-enabled/passenger.load":
        ensure => "../mods-available/passenger.load",
        backup => false,
        require => [Package["libapache2-mod-passenger"]],
        notify => Service["apache2"]
    }
    
    file { "/etc/apache2/mods-enabled/ssl.conf":
        ensure => "../mods-available/ssl.conf",
        backup => false,
        notify => Service["apache2"]
    }
    
    file { "/etc/apache2/mods-enabled/ssl.load":
        ensure => "../mods-available/ssl.load",
        backup => false,
        notify => Service["apache2"]
    }
    
    file { "/etc/apache2/sites-enabled/000-default":
        ensure => absent,
        backup => false
    }
    
    file { "/etc/default/puppetmaster":
        ensure => present,
        source => "puppet:///modules/puppetmaster/defaults-rack",
        backup => false,
    }
    
}