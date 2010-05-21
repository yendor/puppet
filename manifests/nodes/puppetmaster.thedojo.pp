node "puppetmaster.thedojo" {
  $mirror="http://ftp.au.debian.org/debian"
  include common
  include git

  dnsrecord { "thedojo":
    ensure => present,
    type => ".",
    value => "192.168.1.15",
    notify => Exec["rebuild-tinydns-data"]
  }

  dnsrecord { "1.1.10.in-addr.arpa":
    ensure => present,
    type => ".",
    value => "192.168.1.15",
    notify => Exec["rebuild-tinydns-data"]
  }

  dnsrecord { "login.thedojo":
    ensure => present,
    type => "+",
    value => "192.168.1.12",
    notify => Exec["rebuild-tinydns-data"]
  }

  dnsrecord { "thedojo":
    ensure => present,
    type => "'",
    value => "v=spf1 a mx"
  }

  Dnsrecord <<| |>>
}
