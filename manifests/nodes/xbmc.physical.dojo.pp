node 'xbmc.physical.dojo' {
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
