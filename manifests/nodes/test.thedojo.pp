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

    # mysql::user { "Allow access for rodney.amato":
    #     ensure => present,
    #     name => "rodney.amato@localhost",
    #     password_hash => "*514699B1AEE5B468012A8156585A02A6E843B277",
    # }

    mysql_user { "rodney@localhost":
      password_hash => "*514699B1AEE5B468012A8156585A02A6E843B277",
    }

    mysql_grant { "rodney@localhost":
      privileges => "all",
    }
}

