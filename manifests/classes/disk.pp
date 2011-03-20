class disk {
	define scheduler($scheduler = 'cfq') {
		include grub
		
		exec { "live_kernel_scheduler_${name}":
			command => "/bin/echo ${scheduler} > /sys/block/${name}/queue/scheduler",
			unless => "/usr/bin/test $(/bin/sed -r 's{(.*\\[|\\].*){{g' /sys/block/${name}/queue/scheduler) = '${scheduler}'",
			onlyif => "/usr/bin/test -f /sys/block/${name}/queue/read_ahead_kb",			
		}
		
		if ($lsbdistcodename == "lenny") {
			augeas { "boot_kernel_scheduler_${name}":
				context => $lsbdistcodename ? {
					lenny => "/files/boot/grub/menu.lst",
				},
				changes => $lsbdistcodename ? {
					lenny => "set debian/defoptions elevator=${scheduler}",
				},
				notify => Exec["update-grub"],
			}
		}
	}
	
	define readahead($size = '128') {
		exec { "disk_scheduler_${name}":
			command => "/bin/echo ${size} > /sys/block/${name}/queue/read_ahead_kb",
			unless => "/usr/bin/test $(/bin/cat /sys/block/${name}/queue/read_ahead_kb) = '${size}'",
			onlyif => "/usr/bin/test -f /sys/block/${name}/queue/read_ahead_kb",			
		}
	}
}