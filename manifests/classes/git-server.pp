class git-server {
  package { "gitolite":
    ensure => present
  }

  group { "git":
    ensure => present,
    name => "git",
    gid => 201
  }

  user { "git":
    ensure => present,
    name => "git",
    comment => "Gitolite User",
    home => "/home/git",
    shell => "/bin/bash",
    uid => 201,
    gid => "git",
  }

  file { "/home/git":
    ensure => directory,
    owner => "git",
    group => "git",
    backup => false,
    mode => 0700,
    require => [Group["git"], User["git"]]
  }

  file { "/home/git/.ssh":
    ensure => directory,
    owner => "git",
    group => "git",
    mode => 0700,
    backup => false,
    require => File["/home/git"]
  }

  file { "/home/git/seed.pub":
	content => "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAuHykU4qcf4UAFzXG4LPp+ulYY3gCNoOiyUe9Nko+02a+FW/jKkw2ZDoRBhBFzv5kprXyxT+3TvEM2+6T/+aNwCn3vnvNLB21TA/G4CyeSeuHq9VCUxBY5DYrbIB/ZlhHzGjWR8ryaxi2eO7jlN3S7KIk7LVtw0ThK4v+w1zqCcS3eEmtl2m8kfs62ofJ4xtBTWrHHA+2WMb5qDnx6h4oUu18DoFpg2iPZS5pS6It0AxvIgCMJ+63o3YGkQvYKXrAlK9h3XqJU3AEOnkvvkITwdRAXmCH2BFRLErj8MfNyEvIv41XhAP8LITrgBctxSf5zDlPFy37jp4XSt65OgQhDQ== gitolite-seed"
    mode => "0600",
    owner => "git",
    group => "git",
    require => File["/home/git"],
    notify => Exec["initialise-gitolite"]
  }

  exec { "initialise-gitolite":
    command => "/usr/bin/gl-setup /home/git/seed.pub",
    creates => "/home/git/repositories",
    user => "git",
    group => "git",
    cwd => "/home/git",
    refreshonly => true,
    require => [File["/home/git/seed.pub"], User["git"]],
  }

}
