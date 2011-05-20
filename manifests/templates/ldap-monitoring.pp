class ldap-monitoring($instance_name, $ensure => "present", $service_groups='')
{
	include nagios::common
	
	class { "nagios::service":
		name                => "ldap_${fqdn}",
        ensure              => $ensure, 
        host_name           => $fqdn, 
        service_description => "LDAP",
        check_command       => "check_ldap", 
        tag                 => "nagios_monitored_${instance_name}", 
        servicegroups       => $service_groups,
    }
	
}