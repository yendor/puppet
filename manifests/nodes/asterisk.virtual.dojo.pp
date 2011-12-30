node 'asterisk.virtual.dojo' {
  $mirror='http://ftp.au.debian.org/debian'
  $includeBackports=true
  include common

  disk::scheduler{ 'sda':
    scheduler => 'noop'
  }

  ###### BEGIN ASTERISK
  package { 'asterisk':
    ensure => 'present',

  }


  ###### END ASTERISK
}
