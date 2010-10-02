class rodney-home {
  file { "/home/rodney.amato/.vimrc":
    owner => "rodney.amato",
    group => "users",
    mode => "0644",
    source => "puppet:///files/rodney.amato/vimrc",
    require => User["rodney.amato"]
  }

  file { "/home/rodney.amato/.bash_profile":
    owner => "rodney.amato",
    group => "users",
    mode => "0644",
    source => "puppet:///files/rodney.amato/bash_profile",
    require => User["rodney.amato"]
  }

  file { "/home/rodney.amato/.bash_aliases":
    owner => "rodney.amato",
    group => "users",
    mode => "0644",
    source => "puppet:///files/rodney.amato/bash_aliases",
    require => User["rodney.amato"]
  }
}