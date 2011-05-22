class mail-monitoring($instance_name, 
	$host_name,
	$ensure = "present",
	$service_groups='',
	$smtp=true,
	$submission=true,
	$ssmtp=true,
	$pop=true,
	$imap=true,
	$pops=true,
	$imaps=true
)
{
	include nagios::common
	
	if ($smtp) {
		nagios3::service { "check_smtp":
			ensure              => $ensure, 
			host_name           => $host_name, 
			service_description => "SMTP",
			check_command       => "check_smtp", 
			instance_name       => $instance_name, 
			servicegroups       => $service_groups,
		}
	}
	
}