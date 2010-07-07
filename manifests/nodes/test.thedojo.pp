node "test.thedojo" {
    $mirror="http://ftp.au.debian.org/debian"
	include common
	include edge-remote-logging

	include fail2ban

	include rootsh
	realize (User['root'])

	shells { "/bin/bash":
	    ensure => present
	}

	shells { "/bin/false":
	    ensure => present
	}

	shells { "/bin/sh":
	    ensure => present
	}

	shells { "/usr/sbin/nologin":
	    ensure => absent
	}

	shells { "/bin/sync":
	    ensure => present
	}


	include mysql::server
	mysql::user { "Allow access for rodney.amato":
	    ensure => present,
	    name => "rodney.amato@localhost",
	    password_hash => "*514699B1AEE5B468012A8156585A02A6E843B277",
	}

	mysql::rights{"Allow DBA access for rodney.amato":
      ensure   => present,
      user     => "rodney.amato",
      host      => "localhost"
    }
}

