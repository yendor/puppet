class vim {
	package { "vim":
		ensure => present,
		allowcdrom => true,
	}
	file { "/root/.vimrc":
		owner => root,
		group => root,
		mode => 600,
		source => "puppet://puppet/files/root/.vimrc",
		require => Package["vim"]
	}
}

class bash {
	package { "bash":
		ensure => present,
		allowcdrom => true,
	}
	file { "/root/.bashrc":
		owner => root,
		group => root,
		mode => 600,
		source => "puppet://puppet/files/root/.bashrc",
		require => Package["bash"]
	}
	package { "bash-completion":
		ensure => present
	}
}

node basenode {
	include vim, bash
}

node "puppetmaster.thedojo" inherits basenode {
}


