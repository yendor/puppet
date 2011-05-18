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

	file { "/etc/apache2/sites-available/nagios":
		content => template("nagios/apache2-nagios.erb"),
		owner => "root",
		group => "root",
		mode => 644,
		notify => Service["apache2"],
	}

	apache2::site { "nagios": 
		ensure => present,
	}
	apache2::module { "autoindex":
        ensure => absent
    }
}