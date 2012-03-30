class common {
  include vim, bash, ssh-server, less, rsync, apticron, logcheck, mail::aliases, clear-apt-cache, avahi, sudo, htop, bzip2
  include puppet
  include postfix::standard
  include git

  include rodney-home

  $includeBackports=true
  include sources-list, syslog-ng

  include user::unixadmins

  package { [
    "debian-goodies",
    "strace",
    "tmux",
	'psmisc'
  ]:
    ensure => present
  }

  file { "/bin/sh":
    ensure => "bash",
    backup => false
  }

  package { "portmap":
	ensure => absent
  }

  # @@dnsrecord { "forward and reverse dns for $fqdn":
  #     ensure => "present",
  #     type   => "=",
  #     fqdn   => "$fqdn",
  #     ipaddr => "$ipaddress",
  #     ttl    => 300,
  #     notify => Exec["rebuild-tinydns-data"]
  # }

  file { "/etc/network/if-up.d/mountnfs":
	mode => 0755
  }

  augeas{ "boot_delay":
	context => $lsbdistcodename ? {
      lenny   => "/files/boot/grub/menu.lst",
      squeeze => "/files/etc/default/grub",
      oneric => "/files/etc/default/grub",
	},
	changes => $lsbdistcodename ? {
      lenny   => "set timeout 5",
      squeeze => "set GRUB_TIMEOUT 5",
      oneric => "set GRUB_TIMEOUT 5",
    },
    require => Package["lsb-release"],
  }

  if ($operatingsystem == "Debian" and $includeBackports) {
    file { "/etc/apt/preferences":
      content => template("apt/preferences.erb")
    }
  }

  File <<| tag == 'use-apt-proxy' |>>

}
