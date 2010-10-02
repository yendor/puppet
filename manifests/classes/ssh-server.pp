class ssh-server {
    package { "openssh-server":
        ensure => present,
        allowcdrom => true
    }

    service { "ssh":
        ensure => running,
        hasrestart => true,
        hasstatus => true,
        require => Package["openssh-server"]
    }

	file { "/etc/ssh/sshd_config":
		owner => root,
		group => root,
		mode => 0644,
		source => "puppet:///files/etc/ssh/sshd_config",
		notify => Service["ssh"],
		require => Package["openssh-server"]
	}
}
