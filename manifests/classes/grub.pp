class grub {
  exec { "update-grub":
    command     => "/usr/sbin/update-grub",
    refreshonly => true,
  }
}