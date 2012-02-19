node 'graphite.virtual.dojo' {
  $mirror='http://ftp.au.debian.org/debian'
  $includeBackports=true
  include common

  package { 'bzr':
    ensure => present
  }

  package { 'memcached':
    ensure => present,
    enable => true,
  }
  service { 'memcached':
    ensure => running,
  }
  include apache2

  package { [
    'python-django',
    'python-django-tagging',
    'python-memcache',
    'python-twisted',
    'python-zope.interface'
    ]:
    ensure => present
  }
}
