class drobo-monitoring {

	$drobo_hostname = "drobo-fs"
	$drobo_domain = "physical.dojo"
	$drobo_ip = "192.168.1.11"
	$instance_name = "home"

	nagios3::host { "${drobo_hostname}.${drobo_domain}":
		instance_name  => "home",
		address        => $drobo_ip,
		host_name      => "${drobo_hostname}.${drobo_domain}",
		host_alias     => "${dobo_hostname}",
		contact_groups => "admins"
	}

	nagios3::service { "check_smb_photos":
		ensure              => present, 
		host_name           => "${drobo_hostname}.${drobo_domain}", 
		service_description => "Photos Share",
		check_command       => "check_disk_smb!${drobo_ip}!Photos", 
		instance_name       => $instance_name, 
		servicegroups       => $service_groups,
	}

	nagios3::service { "check_smb_music":
		ensure              => present, 
		host_name           => "${drobo_hostname}.${drobo_domain}", 
		service_description => "Music Share",
		check_command       => "check_disk_smb!${drobo_ip}!Music", 
		instance_name       => $instance_name, 
		servicegroups       => $service_groups,
	}

	nagios3::service { "check_smb_movies":
		ensure              => present, 
		host_name           => "${drobo_hostname}.${drobo_domain}", 
		service_description => "Movies Share",
		check_command       => "check_disk_smb!${drobo_ip}!Movies", 
		instance_name       => $instance_name, 
		servicegroups       => $service_groups,
	}

	nagios3::service { "check_smb_tvshows":
		ensure              => present, 
		host_name           => "${drobo_hostname}.${drobo_domain}", 
		service_description => "TV Shows Share",
		check_command       => "check_disk_smb!${drobo_ip}!TVShows", 
		instance_name       => $instance_name, 
		servicegroups       => $service_groups,
	}

	nagios3::service { "check_smb_work":
		ensure              => present, 
		host_name           => "${drobo_hostname}.${drobo_domain}", 
		service_description => "Work Share",
		check_command       => "check_disk_smb!${drobo_ip}!Work", 
		instance_name       => $instance_name, 
		servicegroups       => $service_groups,
	}

}