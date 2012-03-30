node 'xbmc.physical.dojo' {
  $mirror = 'http://au.archive.ubuntu.com/ubuntu'
  include common
  package {[
	'smbfs',
	'aptitude',
	'htop',
	'git',
	'sabnzbdplus'
	]:
	ensure => present
  }
}
