class git-server {
	package { "gitolite":
		ensure => present
	}

	group { "git":
		ensure => present,
		name => "git",
		gid => 201
	}

	user { "git":
		ensure => present,
		name => "git",
		comment => "Gitolite User",
		home => "/home/git",
		shell => "/bin/bash",
		uid => 201,
		gid => "git",
	}

	file { "/home/git":
		ensure => directory,
		owner => "git",
		group => "git",
		backup => false,
		mode => 0700,
		require => [Group["git"], User["git"]]
	}

	file { "/home/git/.ssh":
		ensure => directory,
		owner => "git",
		group => "git",
		mode => 0700,
		backup => false,
		require => File["/home/git"]
	}

}
