class ssh {
    package { "openssh-server":
        ensure => present,
        allowcdrom => true,
    }

	realize(
		Ssh_authorized_key['rodney-windows-home'],
		Ssh_authorized_key['rodney-macbook']
	)

}

