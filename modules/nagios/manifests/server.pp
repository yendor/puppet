class nagios::server ($instance_name, $nagios_version='latest') {
	# Class["nagios::server"] -> Class["apache2"]
	# Class["nagios::server"] -> Class["nagios::common"]

	package { "nagios3":
        alias => "nagios",
        ensure => $nagios_version,
    }

	package { "nagios3-core":
		ensure => $nagios_version,
		require => Package["nagios3-common"],
	}

	package { "nagios3-cgi":
		ensure => $nagios_version,
		require => Package["nagios3-common"],
	}
	package { "nagios3-common":
		ensure => $nagios_version
	}

	package { "nagios-nrpe-plugin":
        ensure => $nagios_version,
        require => Package["nagios"],
    }

   	service { "nagios3":
        alias       => "nagios",
        ensure      => running,
        hasstatus   => true,
        require     => Package["nagios"],
    }

	apache2::site { "nagios": ensure => present }
	apache2::module { "autoindex":
        ensure => absent
    }
}