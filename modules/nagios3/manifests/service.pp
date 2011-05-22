define nagios3::service(
	$instance_name,
    $check_command,
	$ensure = present,
    $host_name = "${fqdn}",
    $use = 'generic-service',
    $notification_period = "24x7",
    $max_check_attempts = 4,
    $retry_check_interval = 1,
    $notification_interval = 960,
    $normal_check_interval = 5,
    $check_period = "24x7",
    $contact_groups = "admins",
    $service_description = 'absent',
    $active_checks_enabled = 1,
    $passive_checks_enabled = 1,
    $check_freshness = 1,
    $freshness_threshold = 0,
    $notifications_enabled = 1,
    $servicegroups = '',
    $depends_on_service = '',
    $depends_on_host_name = ''
) {
	 @@file { "/etc/nagios3/conf.d/${host_name}/${name}.cfg":
		ensure  => $ensure,
		owner   => 'root',
		group   => 'root',
		content => template("nagios/nagios-service.erb"),
		tag     => "nagios_monitored_${instance_name}",
		require => File["/etc/nagios3/conf.d/${host_name}"],
		notify  => Service["nagios"],
     }
}