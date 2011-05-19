class web-monitoring($instance_name, 
	$service_groups='',
	$plain=true,
	$secure=true
)
{
	include nagios::common
	
	if ($plain) {
		class { "nagios::service":
			name                => "check_http",
			ensure              => present, 
			host_name           => $host_name, 
			service_description => "HTTP",
			check_command       => "check_http", 
			instance_name       => $instance_name, 
			servicegroups       => $service_groups,
		}
	}
	
	if ($secure) {
		class { "nagios::service":
			name                => "check_https",
			ensure              => present, 
			host_name           => $host_name, 
			service_description => "HTTPS",
			check_command       => "check_https", 
			instance_name       => $instance_name, 
			servicegroups       => $service_groups,
		}
	}
}