class fail2ban {
  include python-gamin

    package { "fail2ban":
        ensure => present,
        allowcdrom => true
    }


  file { "/etc/fail2ban/jail.local":
    mode => 0600,
    owner => root,
    group => root,
    content => template("etc/fail2ban/jail.local.erb"),
    notify => Exec["reload-fail2ban"],
  }

  file { "/etc/fail2ban/filter.d/dovecot.conf":
    mode => 0600,
    owner => root,
    group => root,
    source => "puppet:///files/etc/fail2ban/filter.d/dovecot.conf",
    notify => Exec["reload-fail2ban"],
  }

  file { "/etc/fail2ban/filter.d/plesk-dovecot.conf":
    mode => 0600,
    owner => root,
    group => root,
    source => "puppet:///files/etc/fail2ban/filter.d/plesk-dovecot.conf",
    notify => Exec["reload-fail2ban"],
  }


  exec { "reload-fail2ban":
    command => "/usr/sbin/invoke-rc.d fail2ban restart",
    refreshonly => true
  }


}


