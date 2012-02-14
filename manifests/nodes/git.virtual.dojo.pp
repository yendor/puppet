node 'git.virtual.dojo' {
  $mirror='http://ftp.au.debian.org/debian'
  $includeBackports=true
  include common

  include git-server


  # gitolite includes
	package { [
		'python-dev',
		'python-pip'
		]:
		ensure => present
	}
}
