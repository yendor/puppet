class dnsrecord::tinydns {
  exec { "reload-tinydns":
    cwd => "/etc/tinydns/root",
    command => "/usr/bin/make",
  }
}