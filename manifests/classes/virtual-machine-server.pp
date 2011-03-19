class virtual-machine-server {
	
	if ($lsbdistcodename == "lenny") {
	    package {  "linux-image-2.6.32-bpo.5-amd64":
	        ensure => present
	    }
	}
    package { "bridge-utils":
        ensure => present
    }

    package { "virtinst":
        ensure => $lsbdistcodename ? {
			lenny => "0.500.3-2~bpo50+1",
			default => "present",
		}
    }
    package { "kvm":
	    ensure => $lsbdistcodename ? {
			lenny => "1:0.12.5+dfsg-3~bpo50+1",
			default => "present",
		}
    }
    package { "qemu-kvm":
	    ensure => $lsbdistcodename ? {
			lenny => "0.12.5+dfsg-3~bpo50+1",
			default => "present",
		}
    }
    package { "libvirt-bin":
	    ensure => $lsbdistcodename ? {
			lenny => "0.8.1-2~bpo50+1",
			default => "present",
		}
    }    
    package { "libvirt0":
	    ensure => $lsbdistcodename ? {
			lenny => "0.8.1-2~bpo50+1",
			default => "present",
		}
    }
    package { "python-libvirt":
	    ensure => $lsbdistcodename ? {
			lenny =>  "0.8.1-2~bpo50+1",
			default => "present",
		}
    }
    
    service { "libvirt-bin":
        ensure => running,
        enable => true,
        hasstatus => true,
        restart => "/etc/init.d/libvirt-bin reload",
        require => Package["libvirt-bin"]
    }

    file { "/etc/libvirt/qemu/autostart":
        ensure => directory,
        backup => false
    }

	exec { "enable_ksm":
		command => "/bin/echo 1 > /sys/kernel/mm/ksm/run",
		unless => "/usr/bin/test $(/sys/kernel/mm/ksm/run) = '1'",
		onlyif => "/usr/bin/test -f /sys/kernel/mm/ksm/run",			
	}    
}
