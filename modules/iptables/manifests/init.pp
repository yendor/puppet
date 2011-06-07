class iptables($include_diff=true) {
    package { "iptables":
		ensure => present
	}
	
    
    file { "/etc/network/if-pre-up.d/iptables-pre-up": 
        source => "puppet:///modules/iptables/iptables-pre-up", 
        mode => 550,
    	owner   => root,
		group   => root,
	    backup => false,
    }

    if ($include_diff) {
        package { "colordiff":
    	    ensure => present
    	}
    
        file { "/usr/local/sbin/fwdiff.sh":
    		source  => "puppet:///modules/iptables/fwdiff.sh",    
    		owner   => root,
    		group   => root,
    		mode    => 0700,
    		backup  => false,
    		require => Package["colordiff"],
    	}
    }
	
	file { "/etc/firewall":
	    ensure => directory,
	    backup => false,
	}
	
	Iptables { 
	    require => File["/etc/firewall"]
	}
}