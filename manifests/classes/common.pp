class common {
  include vim, bash, ssh, less, rsync, apticron, logcheck, mail::aliases, clear-apt-cache, avahi, sudo, htop, bzip2
  include puppet
  include postfix::standard

  include rodney-home

	$includeBackports=true
	include sources-list, backports-keyring, syslog-ng

	include user::unixadmins

	include tinydns::setup

  @@dnsrecord { "forward and reverse dns for $fqdn":
    ensure => "present",
    type => "=",
    fqdn => "$fqdn",
    ipaddr => "$ipaddress",
    ttl => 300,
    notify => Exec["rebuild-tinydns-data"]
  }
}
