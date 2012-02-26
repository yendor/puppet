node "fs1.virtual.dojo" {
  $mirror='http://ftp.au.debian.org/debian'
  $includeBackports=true
  include common

  package { [
	"build-essential",
	"git"
	]:
	ensure => present
  }
}
