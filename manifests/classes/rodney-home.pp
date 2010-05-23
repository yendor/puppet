class rodney-home {
  file { "/home/rodney.amato/.vimrc":
    user => "rodney.amato",
    group => "users",
    mode => "0644",
    source => "puppet://puppet/files/rodney.amato/vimrc",
    require => User["rodney.amato"]
  }

  file { "/home/rodney.amato/.bash_profile":
    user => "rodney.amato",
    group => "users",
    mode => "0644",
    source => "puppet://puppet/files/rodney.amato/bash_profile",
    require => User["rodney.amato"]
  }

  file { "/home/rodney.amato/.bash_aliases":
    user => "rodney.amato",
    group => "users",
    mode => "0644",
    source => "puppet://puppet/files/rodney.amato/bash_aliases",
    require => User["rodney.amato"]
  }
}