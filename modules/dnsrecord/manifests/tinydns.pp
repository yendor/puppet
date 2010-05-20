class dnsrecord::tinydns {
  exec { "reload-tinydns":
    command => "(cd /etc/tinydns/root; /usr/bin/tinydns-data)",
    refreshonly => true
  }
}