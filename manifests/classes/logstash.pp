class logstash {
	include ruby
	package { "logstash":
		ensure => present,
		provider => "gem",
		require => Package["rubygems1.8", "build-essential"],
	}
	
	file { "/etc/logstash":
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => 0755,
		backup => false,
	}
	
	file { "/etc/logstash/config.yaml":
		source => "puppet:///files/logstash/config.yaml",
		owner  => "root",
		group  => "root",
		mode   => 0644,
		backup => false,
		require => File["/etc/logstash"]
	}
	
	file { "/etc/init.d/logstash":
		source => "puppet:///files/logstash/logstash.init",
		owner  => "root",
		group  => "root",
		mode   => 0755,
		backup => false,
		require => Package["logstash"]
	}
	
	package { "build-essential":
		ensure => present,
	}
}
