class puppet {
  package { "puppet":
    ensure => "present",
  }

  file { "/etc/default/puppet":
    owner => root,
    group => root,
    mode => 0644,
    source => "puppet://puppet/files/puppet/default",
    notify => Service["puppet"]
  }

  cron { "puppet":
    ensure  => present,
    command => "/usr/sbin/puppetd --onetime --no-daemonize --logdest syslog > /dev/null 2>&1",
    user    => 'root',
    minute  => ip_to_cron(2)
  }

}