class virtual-machine {
    define kvm (
        $ensure     = "present",
        $ram        = "1024",
        $cpus       = 1,
        $disk_size  = "15G",
        $iso        = "/isos/debian-506-amd64-netinst.iso",
        $nic1       = "bridge:vmbr0",
        $vg         = "kvm_vg",
        $autostart  = "yes"
    ){
        $network = "--network=${nic1}"
        case $ensure {
            present: {
                exec { "lvcreate_disk_${name}":
                    command => "/sbin/lvcreate -n ${name} -L +${disk_size} ${vg}",
                    creates => "/dev/mapper/${vg}-${name}",
                }
                exec { "virt-install_${name}":
                    command => "/usr/bin/virt-install --connect qemu:///system -n ${name} -r ${ram} --vcpus=${cpus} -f /dev/mapper/${vg}-${name} -c ${iso} --vnc --noautoconsole --os-type linux --os-variant debianLenny --accelerate $network --hvm",
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
                    onlyif => "/usr/bin/virsh -c qemu:///system dominfo ${name} | /bin/grep -q 'State:          running'",
                    notify => Service["libvirt-bin"],
                    refreshonly => true
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
}
