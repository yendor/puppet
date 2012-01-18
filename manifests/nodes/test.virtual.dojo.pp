node 'test.virtual.dojo' {
  $mirror='http://ftp.au.debian.org/debian'
  $includeBackports=true
  include common

  include iptables

  include ruby

  package { 'php5-cli':
    ensure => present
  }

  package { [
    'nmap',
    'autoconf'
  ]:
    ensure => present
  }

  package { 'puppet-lint':
    ensure   => present,
    provider => 'gem',
    require  => Class['ruby']
}

  iptables { 'filter-forward-defaultpollicy':
    defaultpolicy => 'DROP',
    table         => 'filter',
    chain         => 'FORWARD',
  }

  iptables { '000 block bogon 127.0.0.0/8 on FORWARD':
    source => '127.0.0.0/8',
    chain  => 'FORWARD',
    jump   => 'DROP'
  }

  nagios3::host { $fqdn:
    instance_name  => 'home',
    address        => $ipaddress,
    host_name      => $fqdn,
    host_alias     => $hostname,
    contact_groups => 'admins'
  }

  # class { 'internal-nagios-server':
  #   instance_name => 'home'
  # }

  # class { 'web-monitoring':
  #   instance_name => 'home',
  #   host_name     => $fqdn,
  # }

  class { 'ssh-monitoring':
    instance_name => 'home',
    host_name     => $::fqdn,
  }

  class { 'nagios3::nrpe':
    bind_to_ip    => $::ipaddress,
    allow_from    => '192.168.1.41',
    instance_name => 'home'
  }

  disk::scheduler{ 'vda':
    scheduler => 'noop'
  }

  disk::readahead { 'vda':
  }

  # augeas { "root_partition_noatime":
  #     context => "/files/etc/fstab",
  #     changes => "set *[file = '/']/opt errors=remount-ro,noatime,nodiratime",
  # }



  iptables { '115 create ratelimited custom chain':
    customchain => 'LIMITED',
    table       => 'filter',
  }

  iptables { 'zzzz - 1 Set a max rate limit to 30 pps average':
    raw_rule => '-A LIMITED -m limit --limit 30/sec --limit-burst 6 -j RETURN',
    table    => 'filter',
  }
  iptables { 'zzzzz - 2 Drop traffic that exceeds the rate limit':
    raw_rule => '-A LIMITED -j DROP',
    table    => 'filter'
  }

  iptables { '115 create aardvark custom chain':
    customchain => 'AARDVARK',
    table       => 'filter',
  }

  iptables { 'zzzz - 1 Set a max aardvark rate limit to 30 pps average':
    raw_rule => '-A AARDVARK -m limit --limit 30/sec --limit-burst 6 -j RETURN',
    table    => 'filter',
  }
  iptables { 'zzzzz - 2 Drop aardvark traffic that exceeds the rate limit':
    raw_rule => '-A AARDVARK -j DROP',
    table    => 'filter'
  }

  iptables { 'allow http(s) traffic':
    chain => 'INPUT',
    dport => ['80', '443'],
    proto => 'tcp',
    jump  => 'ACCEPT'
  }

  # class { 'drobo-monitoring': }
  #
  # package { 'xinetd':
  #     ensure => present
  # }
  #
  # service { 'xinetd':
  #     ensure     => 'running',
  #     hasrestart => true,
  #     hasstatus  => false,
  #     }
  #
  # include cvs


}
