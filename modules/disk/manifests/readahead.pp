define readahead($size = '128') {
	exec { "disk_scheduler_${name}":
		command => "/bin/echo ${size} > /sys/block/${name}/queue/read_ahead_kb",
		unless => "/usr/bin/test $(/bin/cat /sys/block/${name}/queue/read_ahead_kb) = '${size}'",
		onlyif => "/usr/bin/test -f /sys/block/${name}/queue/read_ahead_kb",			
	}
}