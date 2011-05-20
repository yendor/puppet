class ssh-monitoring($instance_name, $host_name, $ensure => "present", $service_groups='')
{
	include nagios::common
	
	nagios::service { "ssh": 
        ensure              => $ensure, 
        host_name           => $host_name, 
        service_description => "SSH",
        check_command       => "check_ssh", 
        instance_name       => $instance_name, 
        servicegroups       => $service_groups,
    }
	
}