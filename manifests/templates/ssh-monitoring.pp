class ssh-monitoring($instance_name, $host_name, $service_groups='')
{
	include nagios::common
	
	class { "nagios::service":
		name                => "ssh",
        ensure              => present, 
        host_name           => $host_name, 
        service_description => "SSH",
        check_command       => "check_ssh", 
        instance_name       => $instance_name, 
        servicegroups       => $service_groups,
    }
	
}