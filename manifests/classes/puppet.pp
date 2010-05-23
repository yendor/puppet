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

  service { "puppet":
    enable => "true",
    ensure => "running",
    hasrestart => "true",
    hasstatus => "true",
  }

}