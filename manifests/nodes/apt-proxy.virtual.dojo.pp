node 'apt-proxy.virtual.dojo' {
  $mirror='http://ftp.au.debian.org/debian'
  $includeBackports=true

  package { 'apt-cacher-ng':
	ensure => present
  }

  @@file { '/etc/apt.conf.d/99proxy':
	ensure => present,
    content => template('apt-cacher/useproxy.erb'),
	tag => 'use-apt-proxy'
  }

  include common
}
