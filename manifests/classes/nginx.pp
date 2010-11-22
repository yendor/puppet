class nginx {
	package { "nginx":
		ensure => "present"
	}
	
	service { "nginx":
		ensure => "running",
		hasrestart => true,
		hasstatus => false,
		require => Package["nginx"]
	}
	
	exec { "reload-nginx":
		command => "/etc/init.d/nginx reload",
    refreshonly => true,
    require => Package["nginx"],
	}
	
  define site ( $ensure = 'present' ) {
      case $ensure {
         'present' : {
            exec { "/bin/ln -s /etc/nginx/sites-available/$name /etc/nginx/sites-enabled/name":
               creates => "/etc/nginx/sites-enabled/$name",
               notify => Exec["reload-nginx"],
               require => [Package["nginx"], File["/etc/nginx/sites-available/$name"]]
            }
						file { "/etc/nginx/sites-available/$name":
							source => "puppet:///files/nginx/$name",
							backup => false
						}
         }
         'absent' : {
            exec { "/bin/rm -f /etc/nginx/sites-enabled/$name":
               onlyif => "/bin/readlink -e /etc/nginx/sites-enabled/$name",
               notify => Exec["reload-nginx"],
               require => Package["nginx"],
            }
         }
         default: { err ( "Unknown ensure value: '$ensure'" ) }
      }
   }
}