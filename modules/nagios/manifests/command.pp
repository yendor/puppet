class nagios::command { $name, $command
	nagios_command { "check_nrpe_daemon":
        ensure          => present,
        command_name    => $name,
        command_line    => $command,
        target          => "/etc/nagios3/conf.d/commands.cfg",
        notify          => Service["nagios3"],
    }
}