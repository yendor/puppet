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
		system => true,
		uid => 201,
		gid => "git",
	}
}
