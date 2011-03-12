class logstash {
	include ruby
	package { "logstash":
		ensure => present,
		provider => "gem",
	}
	
	
}
