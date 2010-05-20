node "puppetmaster.thedojo" {
  $mirror="http://ftp.au.debian.org/debian"
  include common
  include git

  include dnsrecord::tinydns

  dnsrecord { "login.thedojo":
    ensure => "present",
    type => "=",
    value => "192.168.1.12",
    ttl => 300,
    notify => Exec["rebuild-tinydns-data"]
  }

  dnsrecord { "crowd.thedojo":
    ensure => "present",
    type => "=",
    value => "192.168.1.12",
    notify => Exec["rebuild-tinydns-data"]
  }

  dnsrecord { "thedojo":
    ensure => present,
    type => ".",
    value => "",
    notify => Exec["rebuild-tinydns-data"]
  }

}
