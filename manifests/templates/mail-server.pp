class web-monitoring($instance_name, 
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
		nagios::service { "check_smtp":
			ensure              => present, 
			host_name           => $host_name, 
			service_description => "SMTP",
			check_command       => "check_smtp", 
			instance_name       => $instance_name, 
			servicegroups       => $service_groups,
		}
	}
	
}