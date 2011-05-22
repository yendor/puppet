class web-monitoring($instance_name, 
	$ensure = "present",
	$host_name,
	$service_groups='',
	$plain=true,
	$secure=true
)
{
	include nagios::common
	
	if ($plain) {
		nagios3::service { "check_http":
			ensure              => $ensure, 
			host_name           => $host_name, 
			service_description => "HTTP",
			check_command       => "check_http", 
			instance_name       => $instance_name, 
			servicegroups       => $service_groups,
		}
	}
	
	if ($secure) {
		nagios3::service { "check_https":
			ensure              => $ensure, 
			host_name           => $host_name, 
			service_description => "HTTPS",
			check_command       => "check_https", 
			instance_name       => $instance_name, 
			servicegroups       => $service_groups,
		}
	}
}