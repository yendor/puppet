class stunnel {
    package { "stunnel4":
        ensure => present,
    }

	exec { "reload-stunnel":
		command => "/usr/sbin/invoke-rc.d stunnel4 restart",
		refreshonly => true
	}
}

