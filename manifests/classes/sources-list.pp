class sources-list {
	include lsb-base
	file { "/etc/apt/sources.list":
		owner => root,
		group => root,
		mode => 644,
		content => template("etc/apt/$lsbdistid.sources.list.erb"),
		require => Package["lsb-base"],
		notify => Exec["update-packgelist"]
	}

    exec{"update-packgelist":
		command => "/usr/bin/apt-get update"
        refreshonly => true,
        subscribe => File["/etc/apt/sources.list"],
        require => File["/etc/apt/sources.list"],
    }
}
