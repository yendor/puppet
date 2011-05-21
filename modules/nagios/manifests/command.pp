define nagios::command($instance_name,
	$command_name,
	$command_line
) {

	@@file { "/etc/nagios3/conf.d/{$command_name}.cfg":
		content => template("nagios/nagios-command.erb"),
		tag     => "nagios_monitored_${instance_name}",
		require => File["/etc/nagios3/conf.d"],	
		notify  => Service["nagios"],
	}
}