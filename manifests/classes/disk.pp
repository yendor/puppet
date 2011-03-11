class disk {
	define scheduler($scheduler = 'deadline') {
		exec { "live_kernel_scheduler_${name}":
			command => "/bin/echo ${scheduler} > /sys/block/${name}/queue/scheduler",
			unless => "/usr/bin/test $(/bin/sed -r 's{(.*\\[|\\].*){{g' /sys/block/${name}/queue/scheduler) = '${scheduler}'"
		}
		
		augeas { "boot_kernel_scheduler_${name}":
			context => "/files/boot/grub/menu.lst",
			changes => "set debian/defoptions elevator=noop",
			onlyif  => "get debian/defoptions != noop"
		}
	}
}