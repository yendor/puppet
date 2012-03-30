node 'xbmc.physical.dojo' {
  $mirror = 'http://au.archive.ubuntu.com/ubuntu'
  include common
  package {[
	'smbfs',
	'vim',
	'aptitude',
	'htop',
	'git',
	'sabnzbdplus'
	]:
	ensure => present
  }
}
