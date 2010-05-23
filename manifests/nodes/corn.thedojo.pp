node "corn.thedojo" {
  $mirror="http://ftp.au.debian.org/debian"
	include common

  package { "build-essential":
    ensure => "present"
  }

  package { "libncurses5-dev":
    ensure => "present"
  }

  package { "kernel-package":
    ensure => "present"
  }

  package { "fakeroot":
    ensure => "present"
  }
}

