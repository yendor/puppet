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

  dnsrecord { "thedojo.corp":
    ensure => present,
    type => "&",
    value => "192.168.1.11",
    notify => Exec["rebuild-tinydns-data"]
  }
}
