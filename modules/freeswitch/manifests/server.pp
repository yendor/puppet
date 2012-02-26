class freeswitch::server {
  user { "freeswitch":
    ensure => "present",
    home => "/usr/local/freeswitch",
    comment => "FreeSwitch Voice Platform",
    uid => 200,
    gid => 1,
    groups => "audio",
    system => true
  }
}
