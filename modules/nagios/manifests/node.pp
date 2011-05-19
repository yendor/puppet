class nagios::node($instance_name, 
	$host_name,
	$address,
	$host_name,
	$alias,	
	$hostgroups,
	$contact_groups,	
	$check_command="check-host-alive",	
	$max_check_attempts=4,
	$notification_options="d,r",
	$nottification_period="24x7",
	$notification_interval=120,
	$use="generic-host",

) {
	
	@@file { "/etc/nagios3/conf.d/$host_name"
		ensure => directory,
		tag => $instance_name,
	}
	
	@@file { "/etc/nagios3/conf.d/$host_name/host.cfg":
		content => template("templates/nagios-node.erb"),
		tag => $instance_name,
	}
	
}