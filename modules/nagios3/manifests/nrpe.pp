class nagios3::nrpe($bind_to_ip,
	$allow_from,
	$instance_name
) {
	package { "nagios-nrpe-server": 
		ensure => present
	}
    service { "nagios-nrpe-server":
        ensure => true,
        enable => true,
        pattern => "/usr/sbin/nrpe",
        require => Package["nagios-nrpe-server"],
    }
    file { "/etc/nagios/nrpe.cfg":
        ensure => file,
        backup => false,
        content => template("nagios3/nrpe.cfg.erb"),
        require => Package["nagios-nrpe-server"],
        notify => Service["nagios-nrpe-server"],
    }
    file { "/etc/nagios/nrpe.d":
        ensure  => directory,
        owner   => "root",
        group   => "root",
        backup  => false,
        require => Package["nagios-nrpe-server"],
        notify  => Service["nagios-nrpe-server"],
    }

	nagios3::service { "nrpe":
        service_description => "NRPE",
        check_command       => "check_nrpe_daemon",
		instance_name       => $instance_name
	}

}