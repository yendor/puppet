class sources-list {
	file { "/etc/apt/sources.list":
		owner => root,
		group => root,
		mode => 644,
		content => template("etc/apt/$lsbdistid.sources.list.erb"),
	}

    exec{"/usr/bin/apt-get update":
        refreshonly => true,
        subscribe => File["/etc/apt/sources.list"],
        require => File["/etc/apt/sources.list"],
    }
}
