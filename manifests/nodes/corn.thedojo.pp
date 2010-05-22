node "corn.thedojo" {
  $mirror="http://ftp.au.debian.org/debian"
	include common

  package { "build-essential":
    ensure => "present"
  }

}

