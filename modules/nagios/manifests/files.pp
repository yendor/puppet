class nagios::files {
	# Remove Standard Debian Files that are created from nagios package
    file {[
        "/etc/nagios3/conf.d/contacts_nagios2.cfg",
        "/etc/nagios3/conf.d/localhost_nagios3.cfg",
        "/etc/nagios3/conf.d/extinfo_nagios3.cfg",
        "/etc/nagios3/conf.d/services_nagios3.cfg"
        ]:
            ensure => absent,
            backup => false,
            notify => Service["nagios"],
    }
    file { "/var/lib/nagios3":
        ensure  => directory,
        mode    => 751,
        owner   => nagios,
        group   => nagios,
        notify  => Service["nagios"],
    }

	# Main Nagios cfg file
    file { "/etc/nagios3/nagios.cfg":
        content => template("nagios/nagios.cfg.erb"),
        require => Package["nagios"],
        notify => Service["nagios"],
    }

    # Cgi config file for controlling access to cgi
    rfile { "/etc/nagios3/cgi.cfg":
        source => "/nagios/cgi.cfg",
        require => Package["nagios"],
        notify => Service["nagios"],
    }

    # Commands config
    rfile { "/etc/nagios3/commands.cfg":
        source  => "nagios/commands.cfg",
        require => Package["nagios"],
        notify  => Service["nagios"],
    }

	file { "/etc/apache2/sites-available/nagios": 
		content => template("nagios/apache2-nagios.erb"), 
		notify => Service["apache2"]
	}
}