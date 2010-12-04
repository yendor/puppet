class server {
    package {  "linux-image-2.6.32-bpo.5-amd64":
        ensure => present
    }
    package { "bridge-utils":
        ensure => present
    }
    package { "virtinst":
        ensure => present
    }
    package { "libvirt-bin":
        ensure => present
    }
    package { "kvm":
        ensure => present
    }
    package { "lvm2":
        ensure => present
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
}
