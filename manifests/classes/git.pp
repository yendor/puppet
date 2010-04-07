class git {
    package { "git-core":
    	ensure => installed
    }

    package { "git-commit-notifier":
    	ensure => installed,
    	provider => "gem",
    	require => [Package["hpricot"], Package["mocha"], Package["diff-lcs"], Package["git-core"]]
    }

    package { "hpricot":
    	ensure => installed,
    	provider => "gem",
    	require => [Package["ruby1.8-dev"], Package["build-essential"]]
    }

    package { "mocha":
    	ensure => installed,
    	provider => "gem"
    }

    package { "diff-lcs":
    	ensure => installed,
    	provider => "gem"
    }

    package { "ruby1.8-dev":
    	ensure => installed
    }

    package { "build-essential":
    	ensure => installed
    }
}