class freeswitch::build {
  package { [
	"build-essential",
	"autoconf",
	"libtool",
	"libncurses5-dev",
	"libjpeg62",
	"libjpeg62-dev",
	"zlib1g-dev",
	"git"
	]:
	ensure => present
  }
}
