class nagios::server (
	$instance_name, 
	$nagios_ssl_key_file, 
	$nagios_ssl_cert_file, 
	$nagios_version='installed', 
	$nagios_ssl_ca_file='', 
	$nagios_web_ip='*') {
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
	
	file { "/etc/apache2/conf.d/nagios3.conf":
		ensure => "absent"
	}

	apache2::site { "nagios": 
		ensure => present,
	}
	apache2::module { ["autoindex"]:
        ensure => absent
    }
	apache2::module { ["rewrite"]:
        ensure => present
    }
}