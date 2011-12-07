class ruby {

	$ruby_version = $lsbdistcodename ? {
	    lenny => "1.8.7.302-2~bpo50+1",
	    default => "present"
	}

	package { "rubygems1.8":
		ensure => $lsbdistcodename ? {
		    lenny => "1.3.4-1~bpo50+1",
		    default => "present"
		},
		require => Package["lsb-release"]
	}

	package { "libruby1.8":
		ensure => "$ruby_version"
	}

	package { "ruby1.8":
		ensure => "$ruby_version",
		require => Package["libruby1.8"]
	}

	package { "ruby1.8-dev":
		ensure => "$ruby_version",
		require => Package["libruby1.8"]
	}

}
