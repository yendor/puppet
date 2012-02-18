node 'graphite.virtual.dojo' {
  $mirror='http://ftp.au.debian.org/debian'
  $includeBackports=true
  include common

  package { 'bzr':
    ensure => present
  }
}
