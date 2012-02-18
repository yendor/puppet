node 'apt-proxy.virtual.dojo' {
  $mirror='http://ftp.au.debian.org/debian'
  $includeBackports=true
  include common

  package { 'apt-cacher-ng':
	ensure => present
  }
}
