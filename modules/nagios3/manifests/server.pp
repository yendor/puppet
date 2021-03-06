class nagios3::server (
  $instance_name, 
  $nagios_ssl_key_file, 
  $nagios_ssl_cert_file, 
  $nagios_version='installed', 
  $nagios_ssl_ca_file='', 
  $nagios_web_ip='*') {

  package { "nagios3":
        alias => "nagios",
        ensure => $nagios_version,
    }

  package { "nagios3-core":
    ensure => $nagios_version,
    require => Package["nagios3-common"],
  }

  package { "nagios3-cgi":
    ensure => $nagios_version,
    require => Package["nagios3-common"],
  }
  package { "nagios3-common":
    ensure => $nagios_version
  }

  package { "nagios-nrpe-plugin":
        ensure => "installed",
        require => Package["nagios"],
    }

  nagios3::command { "check_nrpe_daemon":
    command_line => "/usr/lib/nagios/plugins/check_tcp -H '\$HOSTADDRESS\$' -p 5666 -t 20",
    instance_name => $instance_name
  }

    # Fix default debian permissions for the external command file so we can use it from the web interface
    exec { "fix_nagios_command_permissions_1":
        command     => "/usr/sbin/dpkg-statoverride --update --add nagios www-data 2710 /var/lib/nagios3/rw",
        refreshonly => true,
        subscribe   => Package["nagios"],
        notify      => Service["nagios"],
    }
    exec { "fix_nagios_command_permissions_2":
        command     => "/usr/sbin/dpkg-statoverride --update --add nagios nagios 751 /var/lib/nagios3",
        refreshonly => true,
        subscribe   => Package["nagios"],
        notify      => Service["nagios"],
    }

    service { "nagios3":
        alias       => "nagios",
        ensure      => running,
        hasstatus   => true,
        require     => Package["nagios"],
    }

  file { "/etc/apache2/sites-available/nagios":
    content => template("nagios3/apache2-nagios.erb"),
    owner => "root",
    group => "root",
    mode => 644,
    notify => Service["apache2"],
  }
  
  file { "/etc/apache2/conf.d/nagios3.conf":
    ensure => "absent",
    backup => false,
    notify => Service["apache2"],
  }

  apache2::site { "nagios": 
    ensure => present,
  }
  apache2::module { ["autoindex"]:
        ensure => absent
    }
  apache2::module { ["rewrite"]:
        ensure => present
    }

  class { "nagios3::resources":
    instance_name => $instance_name
  }
  
  file { "/etc/nagios3/conf.d":
    ensure => directory
  }
  
  file { [
    "/etc/nagios3/conf.d/localhost_nagios2.cfg",
    "/etc/nagios3/conf.d/hostgroups_nagios2.cfg",
    "/etc/nagios3/conf.d/services_nagios2.cfg",
    "/etc/nagios3/conf.d/extinfo_nagios2.cfg",
    "/etc/nagios3/conf.d/gateway_nagios3.cfg",
    "/etc/nagios3/conf.d/host-gateway_nagios3.cfg",
    ] :
    ensure => absent,
    backup => false,
    notify => Service["nagios"],
  }
  
  file { "/etc/nagios3/nagios.cfg":
    source => "puppet:///modules/nagios3/nagios/nagios.cfg",
    backup => false,
    mode   => 644,
    owner  => root,
    group  => root,
    notify => Service["nagios"],
  }
}