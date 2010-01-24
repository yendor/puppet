class clear-apt-cache {
	cron { "clear-apt-cache":
		ensure => present,
		command => "/usr/bin/apt-get clean",
		user => "root",
		weekday => "Friday",
		hour => 5,
		minute => 23
	}
}
