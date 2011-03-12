class logstash {
	include ruby
	package { "logstash":
		ensure => present,
		provider => "gem",
		require => Package["rubygems1.8", "make"],
	}
	
	package { "make":
		ensure => present,
	}
}
