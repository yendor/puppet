class nagios::service(
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

	@@nagios_service { $name:
	     ensure                  => $ensure,
	     service_description     => $use_service_description,
	     check_command           => $check_command,
	     use                     => $use,
	     host_name               => $host_name,
	     notification_period     => $notification_period,
	     max_check_attempts      => $max_check_attempts,
	     retry_check_interval    => $retry_check_interval,
	     notification_interval   => $notification_interval,
	     normal_check_interval   => $normal_check_interval,
	     contact_groups          => $contact_groups,
	     check_period            => $check_period,
	     active_checks_enabled   => $active_checks_enabled,
	     passive_checks_enabled  => $passive_checks_enabled,
	     check_freshness         => $check_freshness,
	     freshness_threshold     => $freshness_threshold,
	     notifications_enabled   => $notifications_enabled,
	     notify                  => Service["nagios"],
	     target                  => "/etc/nagios3/conf.d/service-${name}.cfg",
	     require                 => File["/etc/nagios3/conf.d/service-${name}.cfg"],
	     servicegroups           => $servicegroups ? {
	         ''      => undef,
	         default => $servicegroups,
	     },
	     tag                     => "nagios_monitored_${instance_name}", 
	 }
	
	 @@file { "/etc/nagios3/conf.d/service-${name}.cfg":
         ensure => $ensure,
         owner  => 'nagios',
         group  => 'nagios',
         tag    => "nagios_monitored_${instance_name}", 
     }
}