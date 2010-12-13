node "leech.virtual.dojo" {
  $mirror="http://ftp.au.debian.org/debian"
  include common

  include transmission

  augeas { "root_partition_noatime":
      context => "/files/etc/fstab",
      changes => "set *[file = '/']/opt errors=remount-ro,noatime,nodiratime",
  }
}