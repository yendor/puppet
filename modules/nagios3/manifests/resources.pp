class nagios3::resources($instance_name) {
  #Nagios_command <<| tag == "nagios_monitored_${instance_name}" |>>
  Nagios_contact <<| tag == "nagios_monitored_${instance_name}" |>>
  Nagios_contactgroup <<| tag == "nagios_monitored_${instance_name}" |>>
  #Nagios_host <<| tag == "nagios_monitored_${instance_name}" |>>
  Nagios_hostextinfo <<| tag == "nagios_monitored_${instance_name}" |>>
  Nagios_hostgroup <<| tag == "nagios_monitored_${instance_name}" |>>
  Nagios_hostgroupescalation <<| tag == "nagios_monitored_${instance_name}" |>>
  #Nagios_service <<| tag == "nagios_monitored_${instance_name}" |>>
  Nagios_servicedependency <<| tag == "nagios_monitored_${instance_name}" |>>
  Nagios_serviceescalation <<| tag == "nagios_monitored_${instance_name}" |>>
  Nagios_serviceextinfo <<| tag == "nagios_monitored_${instance_name}" |>>
  Nagios_timeperiod <<| tag == "nagios_monitored_${instance_name}" |>>
  File <<| tag == "nagios_monitored_${instance_name}" |>>
}