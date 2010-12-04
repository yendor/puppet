node "test.virtual.dojo" {
  $mirror="http://ftp.au.debian.org/debian"
  $includeBackports=true
  include common
  include puppetmaster
}