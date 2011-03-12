class logstash {
	package { "logstash":
		ensure => present,
		provider => "gem",
	}
	
	
}
