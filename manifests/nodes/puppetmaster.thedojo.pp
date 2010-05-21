node "puppetmaster.thedojo" {
  $mirror="http://ftp.au.debian.org/debian"
  include common
  include git

  dnsrecord { "nameserver for thdojo":
    ensure => present,
    type => ".",
    fqdn => "thedojo",
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

  dnsrecord { "txt record for thedojo":
    ensure => present,
    fqdn => "thedojo",
    type => "'",
    value => "v=spf1 a mx",
    notify => Exec["rebuild-tinydns-data"]
  }

  Dnsrecord <<| |>>
}
