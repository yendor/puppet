define guest (
    $ensure     = "present",
    $ram        = "1024",
    $cpus       = 1,
    $disk_size  = "15G",
    $iso        = "http://ftp.au.debian.org/debian/dists/lenny/main/installer-amd64/",
    $nic1       = "bridge:vmbr0",
    $vg         = "kvm_vg",
    $autostart  = "yes",
    $extra_args = ""
){
    $network = "--network=${nic1}"
    $extra_args_to_use = "hostname=${name} domain=virtual.dojo ${extra_args}"
    case $ensure {
        present: {
            exec { "lvcreate_disk_${name}":
                command => "/sbin/lvcreate -n ${name} -L +${disk_size} ${vg}",
                creates => "/dev/mapper/${vg}-${name}",
                unless => "/usr/bin/stat /dev/mapper/${vg}-${name}",
            }
            exec { "virt-install_${name}":
                command => "/usr/bin/virt-install --connect qemu:///system -n ${name} -r ${ram} --vcpus=${cpus} -f /dev/mapper/${vg}-${name} -l ${iso} --vnc --noautoconsole --os-type linux --os-variant debianlenny --accelerate $network --hvm --extra-args=\"${extra_args_to_use}\"",
                creates => "/etc/libvirt/qemu/${name}.xml",
                require => [Package["virtinst"],Package["libvirt-bin"],Service["libvirt-bin"],Exec["lvcreate_disk_${name}"]],
                unless => "/usr/bin/stat /etc/libvirt/qemu/${name}.xml",
            }
            if $autostart == "yes" {
                file { "/etc/libvirt/qemu/autostart/${name}.xml":
                    ensure => "/etc/libvirt/qemu/${name}.xml",
                    backup => false
                }
            }
        }
        absent: {
            exec { "virt_stop_vm_${name}":
                command => "/usr/bin/virsh -c qemu:///system destroy ${name}",
                onlyif => "/usr/bin/virsh -c qemu:///system domstate ${name} >/dev/null",
                notify => Service["libvirt-bin"],
            }

            exec { "lvremove_disk_${name}":
                command => "/sbin/lvremove -f /dev/mapper/${vg}-${name}",
                onlyif => "/usr/bin/test -b /dev/mapper/${vg}-${name}",
                require => Exec["virt_stop_vm_${name}"],
            }

            file { "/etc/libvirt/qemu/autostart/${name}.xml":
                ensure => absent,
                backup => false,
                require => Exec["virt_stop_vm_${name}"],
            }

            file { "/etc/libvirt/qemu/${name}.xml":
                ensure => absent,
                backup => false,
                require => Exec["virt_stop_vm_${name}"],
            }
        }
    }
}
