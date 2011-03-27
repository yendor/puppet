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
		require => File["/etc/logstash"],
		notify => Service['logstash'],
	}
	
	file { "/etc/init.d/logstash":
		source => "puppet:///files/logstash/logstash.init",
		owner  => "root",
		group  => "root",
		mode   => 0755,
		backup => false,
		require => Package["logstash"]
	}
	
	file { "/etc/init.d/logstash-web":
		source => "puppet:///files/logstash/logstash-web.init",
		owner  => "root",
		group  => "root",
		mode   => 0755,
		backup => false,
		require => Package["logstash"]
	}
	
	service { "logstash":
		ensure     => running,
		enable     => true,
		hasstatus  => true,
		hasrestart => true,
		require    => File["/etc/init.d/${name}"],		
	}
	
	service { "logstash-web":
		ensure     => running,
		enable     => true,
		hasstatus  => true,
		hasrestart => true,
		require    => File["/etc/init.d/${name}"],
	}
	
	package { "build-essential":
		ensure => present,
	}
}
