node "leech.virtual.dojo" {
  $mirror="http://ftp.au.debian.org/debian"
  include common

  include transmission

  augeaus { "root_partition_noatime":
      contect => "/files/etc/fstab",
      changes => "set *[file = '/']/opt errors=remount-ro,noatime,nodiratime",
  }
}