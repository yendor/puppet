node "fs1.virtual.dojo" {
  $mirror='http://ftp.au.debian.org/debian'
  $includeBackports=true
  include common

  include freeswitch::build
  include freeswitch::server

  package { 'imagemagick':
    ensure => present
  }

}
