class transmission-monitoring($instance_name, 
	$host_name,
	$ensure = "present",
	$service_groups=''
)
{
	include nagios::common
	
	nagios::service { "check_transmission_web":
		ensure              => $ensure, 
		host_name           => $host_name, 
		service_description => "Transmission Web",
		check_command       => "check_transmission!9091", 
		instance_name       => $instance_name, 
		servicegroups       => $service_groups,
	}
	
	nagios::command { "check_transmission":
		instance_name => $instance_name,
		command_line => "/usr/lib/nagios/plugins/check_http -H '\$HOSTADDRESS$' -I '\$HOSTADDRESS$' -p '\$ARG1'"
	}
}