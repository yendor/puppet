class nagios::server ($instance_name, $nagios_version='installed', $nagios_ssl_key_file, $nagios_ssl_cert_file, $nagios_ssl_ca_file='') {
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
        ensure => "installed",
        require => Package["nagios"],
    }

   	service { "nagios3":
        alias       => "nagios",
        ensure      => running,
        hasstatus   => true,
        require     => Package["nagios"],
    }

	apache2::site { "nagios": 
		ensure => present,
		require => File[$nagios_ssl_cert_file, $nagios_ssl_key_file],
	}
	apache2::module { "autoindex":
        ensure => absent
    }
}