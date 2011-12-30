class nagios3::hostgroup { $name
  nagios_hostgroup { $name:
    ensure => present,
    target => "/etc/nagios3/conf.d/hostgroups.cfg",
    require => Package["nagios"],
    notify => Service["nagios"],
  }
}