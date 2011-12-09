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

	ssh_authorized_key{ "gitolite-seed":
		ensure => present,
		key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCu2AwOz+TTGgehU9FXtNjq5vR1l8dXSlTLp44c9Ce/UdF+yyx2S5435Tcw/2EcuQXTEwAr+VjXla/f/2O1UEvFbgTcTt/VNd1oFVueZP0OTAA5HGUpMJNmTbozrGMUIPMM3Ew6NDIpGdJZGjdxn2/ZYg4PHEQqnrSCXM7ZhKKJ1qzrothh84Tna/3eDwMg9qnqaso7d4P29a7YMya+XzDwB0HPk4eWXfSwRvNR+CxSiGMlalY4tDldW7xc9C0KDth1sMG4KjQvc6LlpF2T+P8YismcVAI+YF8jyakjrkhYZyl2GOzM0Wif8/6hTIxRp/XocB3/CrsYdzoevLulSllR",
		type => "ssh-rsa",
		user => "git",
		target => "/home/git/seed.pub",
		require => File["/home/git"]
	}

	file { "/home/git/seed.pub":
		mode => "0600",
		owner => "git",
		group => "git",
		require => User["git"],
		notify => Exec["initialise-gitolite"],
	}

	exec { "initialise-gitolite":
		command => "/usr/bin/gl-setup /home/git/seed.pub",
		creates => "/home/git/repositories",
		refreshonly => true,
	}

}
