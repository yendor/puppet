class ssh {
    package { "openssh-server":
        ensure => present,
        allowcdrom => true,
    }

	exec { "reload-sshd":
		command => "/usr/sbin/invoke-rc.d ssh restart",
		refreshonly => true
	}
}

