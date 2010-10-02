class sshd-config {
	file { "/etc/ssh/sshd_config":
		owner => root,
		group => root,
		mode => 0644,
		source => "puppet:///files/etc/ssh/sshd_config",
		notify => Exec["reload-sshd"],
	}
}
