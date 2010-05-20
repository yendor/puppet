class tinydns::setup {
  exec { "rebuild-tinydns-data":
    cwd => "/etc/tinydns/root",
    command => "/usr/bin/make",
    refreshonly => true
  }
}