class virtual-machine-server {
    package {  "linux-image-2.6.32-bpo.5-amd64":
        ensure => present
    }
    package { "bridge-utils":
        ensure => present
    }
    package { "virtinst":
        ensure => "0.500.3-2~bpo50+1"
    }
    package { "kvm":
        ensure => "1:0.12.5+dfsg-3~bpo50+1"
    }
    package { "qemu-kvm":
        ensure => "0.12.5+dfsg-3~bpo50+1"
    }
    package { "libvirt-bin":
        ensure => "0.8.1-2~bpo50+1"
    }    
    package { "libvirt0":
        ensure => "0.8.1-2~bpo50+1"
    }
    package { "python-libvirt":
        ensure => "0.8.1-2~bpo50+1"
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
    
    file { "/sys/kernel/mm/ksm/run":
        contents => "1",
        backup => false,
        require => Package["linux-image-2.6.32-bpo.5-amd64"]
    }
}
