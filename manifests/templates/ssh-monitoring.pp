class ssh-monitoring($instance_name, $service_groups='')
{
	include nagios::common
	
	class { "nagios::service":
		name                => "ssh_${fqdn}",
        ensure              => present, 
        host_name           => $fqdn, 
        service_description => "SSH",
        check_command       => "check_ssh", 
        instance_name       => $instance_name, 
        servicegroups       => $service_groups,
    }
	
}