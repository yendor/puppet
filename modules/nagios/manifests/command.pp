define nagios::command($instance_name,
	$command_line,
	$ensure='present'
) {

	@@file { "/etc/nagios3/conf.d/${name}.cfg":
		ensure => $ensure,
		content => template("nagios/nagios-command.erb"),
		tag     => "nagios_monitored_${instance_name}",
		require => File["/etc/nagios3/conf.d"],	
		notify  => Service["nagios"],
	}
}