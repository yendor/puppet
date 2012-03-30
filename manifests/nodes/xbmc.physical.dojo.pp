node 'xbmc.physical.dojo' {
  $mirror = 'http://au.archive.ubuntu.com/ubuntu'
  include common
  package {[
	'smbfs',
	'aptitude',
	'git',
	'sabnzbdplus'
	]:
	ensure => present
  }
}
