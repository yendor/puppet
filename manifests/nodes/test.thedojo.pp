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

    mysql_user { "rodney.amato@localhost":
      password_hash => "*A7A4903BB2E3ACFB56A979999FE70BA1ECAE5433",
    }

    mysql_grant { "rodney.amato@localhost":
      privileges => "all",
    }
}

