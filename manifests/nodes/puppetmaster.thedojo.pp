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
    notify => Exec["reload-tinydns"]
  }

  dnsrecord { "crowd.thedojo":
    ensure => "present",
    type => "a",
    value => "192.168.1.12",
    ttl => 300,
    notify => Exec["reload-tinydns"]
  }

}
