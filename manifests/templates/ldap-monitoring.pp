class ldap-monitoring($instance_name, $service_groups='')
{
	include nagios::common
	
	class { "nagios::service":
		name                => "ldap_${fqdn}",
        ensure              => present, 
        host_name           => $fqdn, 
        service_description => "LDAP",
        check_command       => "check_ldap", 
        tag                 => "nagios_monitored_${instance_name}", 
        servicegroups       => $service_groups,
    }
	
}