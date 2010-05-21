node "puppetmaster.thedojo" {
  $mirror="http://ftp.au.debian.org/debian"
  include common
  include git

  dnsrecord { "nameserver for thdojo":
    ensure => present,
    type => ".",
    fqdn => "thedojo",
    ipaddr => "192.168.1.15",
    notify => Exec["rebuild-tinydns-data"]
  }

  dnsrecord { "reverse dns for 192.168.1.0/24 subnet":
    ensure => present,
    type => ".",
    fqdn => "1.168.192.in-addr.arpa",
    ipaddr => "192.168.1.15",
    notify => Exec["rebuild-tinydns-data"]
  }

  dnsrecord { "alias for login.thedojo":
    ensure => present,
    type => "+",
    fqdn => "login.thedojo",
    ipaddr => "192.168.1.12",
    notify => Exec["rebuild-tinydns-data"]
  }

  dnsrecord { "alias for the puppet.thedojo dns entry":
    ensure => present,
    type => "+",
    fqdn => "puppet.thedojo",
    ipaddr => "192.168.1.15",
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
