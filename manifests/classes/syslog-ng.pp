class syslog-ng {
  package { "syslog-ng":
    ensure => present
  }

  service { "syslog-ng":
    ensure => running,
    hasstatus => false,
    hasrestart => true,
  }

  if ($virtual == "openvzve") {
    file { "/etc/default/syslog-ng":
      source => "puppet:///files/syslog-ng/default-openvze",
      notify => Service["syslog-ng"]
    }
  }
}