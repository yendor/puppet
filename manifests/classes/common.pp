class common {
#	include shared-hosts
    include vim, bash, ssh, less, rsync, apticron, logcheck, mail::aliases, clear-apt-cache, avahi, sudo, htop

    include postfix::standard

	$includeBackports=true
	include sources-list, backports-keyring

	include user::unixadmins

	include dnsrecord::tinydns

  @@dnsrecord { "$fqdn":
    ensure => "present",
    type => "=",
    value => "$ipaddress",
    ttl => 300,
    notify => Exec["rebuild-tinydns-data"]
  }
}
