$apache_sites = "/etc/apache2/sites"
$apache_mods = "/etc/apache2/mods"

class apache2 {

   # Define an apache2 site. Place all site configs into
   # /etc/apache2/sites-available and en-/disable them with this type.
   #
   # You can add a custom require (string) if the site depends on packages
   # that aren't part of the default apache2 package. Because of the
   # package dependencies, apache2 will automagically be included.
   define site ( $ensure = 'present' ) {
      case $ensure {
         'present' : {
            if $require {
                exec { "/usr/sbin/a2ensite $name":
                   creates => "/etc/apache2/sites-enabled/$name",
                   notify => Exec["reload-apache2"],
                   require => [Package[$require], Package["apache2"]],
                }
            }
            else {
                exec { "/usr/sbin/a2ensite $name":
                   creates => "/etc/apache2/sites-enabled/$name",
                   notify => Exec["reload-apache2"],
                   require => Package["apache2"],
                }
            }
         }
         'absent' : {
            exec { "/usr/sbin/a2dissite $name":
               onlyif => "/bin/readlink -e ${apache2_sites}-enabled/$name",
               notify => Exec["reload-apache2"],
               require => Package["apache2"],
            }
         }
         default: { err ( "Unknown ensure value: '$ensure'" ) }
      }
   }

   # Define an apache2 module. Debian packages place the module config
   # into /etc/apache2/mods-available.
   #
   # You can add a custom require (string) if the module depends on
   # packages that aren't part of the default apache2 package. Because of
   # the package dependencies, apache2 will automagically be included.
  define module ( $ensure = 'present') {
    case $ensure {
      'present' : {
        exec { "/usr/sbin/a2enmod $name":
          unless => "/bin/sh -c '[ -L ${apache_mods}-enabled/${name}.load ] && [ ${apache_mods}-enabled/${name}.load -ef ${apache_mods}-available/${name}.load ]'",
                require => Package["apache2"],
          notify => Exec["force-reload-apache2"],
        }
      }
      'absent': {
        exec { "/usr/sbin/a2dismod $name":
          onlyif => "/bin/sh -c '[ -L ${apache_mods}-enabled/${name}.load ] && [ ${apache_mods}-enabled/${name}.load -ef ${apache_mods}-available/${name}.load ]'",
          notify => Exec["force-reload-apache2"],
        }
      }
      default: { err ( "Unknown ensure value: '$ensure'" ) }
    }
  }

   # Notify this when apache needs a reload. This is only needed when
   # sites are added or removed, since a full restart then would be
   # a waste of time. When the module-config changes, a force-reload is
   # needed.
   exec { "reload-apache2":
      command => "/etc/init.d/apache2 reload",
      refreshonly => true,
      require => Package["apache2"],
   }

   exec { "force-reload-apache2":
      command => "/etc/init.d/apache2 force-reload",
      refreshonly => true,
      require => Package["apache2"],
   }

   package { "apache2": ensure => present }
   package { "apache2-doc": ensure => absent }
   # We want to make sure that Apache2 is running.
   service { "apache2":
      ensure     => running,
      hasstatus  => true,
      hasrestart => true,
      require    => Package["apache2"],
   }

   file { "/etc/apache2/mods-available/alias.conf":
      content => "",
      notify  => Exec["reload-apache2"],
      require => Package["apache2"]
   }

  package { "libapache2-mod-macro":
    ensure => installed
  }

  apache2::module { "macro":
    ensure => present,
    require => Package["libapache2-mod-macro"]
  }

   # Make sure the security is configured for production
   file { "/etc/apache2/conf.d/security": 
    source => "puppet:///files/apache2/security", 
    notify => Exec["reload-apache2"], 
    require => Package["apache2"]
  }

   # Make sure to remove the default apache2 manual config....this by default allows directory browsing which breaks PCI DSS
   file { "/etc/apache2/conf.d/apache2-doc": 
    ensure => absent, 
    backup => false, 
    notify => Service["apache2"]
  }

   # # Setup log rotation for apache
   # rfile { "/etc/logrotate.d/apache2":
   #    source => "apache2/logrotate",
   #    require => Package["logrotate"],
   # }
}

class apache2::mpm-worker inherits apache2 {
  package { "apache2-mpm-worker":
    ensure => installed,
  }
}

class apache2::mpm-prefork inherits apache2 {
  package { "apache2-mpm-prefork":
    ensure => installed,
  }
}

class apache2::mpm-event inherits apache2 {
  package { "apache2-mpm-event":
    ensure => installed,
  }
}


