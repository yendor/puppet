class disk {
	define scheduler($scheduler = 'deadline') {
		include grub
		
		exec { "live_kernel_scheduler_${name}":
			command => "/bin/echo ${scheduler} > /sys/block/${name}/queue/scheduler",
			unless => "/usr/bin/test $(/bin/sed -r 's{(.*\\[|\\].*){{g' /sys/block/${name}/queue/scheduler) = '${scheduler}'",
			onlyif => "/usr/bin/test -f /sys/block/${name}/queue/read_ahead_kb",			
		}
		
		augeas { "boot_kernel_scheduler_${name}":
			context => "/files/boot/grub/menu.lst",
			changes => "set debian/defoptions elevator=noop",
			onlyif  => "get debian/defoptions != noop",
			notify => Exec["update-grub"],
		}
	}
	
	define readahead($size = '65536') {
		file { "/sys/block/${name}/queue/read_ahead_kb":
			content => $size,
			backup => false,
		}
	}
}