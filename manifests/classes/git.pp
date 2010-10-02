class git {
    package { "git-core":
    	ensure => installed
    }

    package { "git-commit-notifier":
    	ensure => installed,
    	provider => "gem",
    	require => [Package["libhpricot-ruby"], Package["libmocha-ruby"], Package["libdifflcs-ruby"], Package["git-core"]]
    }

    package { "libhpricot-ruby":
    	ensure => present,
    	require => [Package["ruby1.8-dev"], Package["build-essential"]]
    }

    package { "libmocha-ruby":
    	ensure => present,
    }

    package { "libdifflcs-ruby":
    	ensure => prsent,
    }

    package { "ruby1.8-dev":
    	ensure => installed
    }

    package { "build-essential":
    	ensure => installed
    }
}