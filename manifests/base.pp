class vim {
	package { "vim":
		ensure => present,
		allowcdrom => true,
	}
	file { "/root/.vimrc":
		owner => root,
		group => root,
		mode => 600,
		source => "puppet://puppet/files/root/.vimrc",
		require => Package["vim"]
	}
}

class less {
	package { "less":
		ensure => present,
		allowcdrom => true,
	}
}

class rsync {
	package { "rsync":
		ensure => present,
		allowcdrom => true,
	}
}

class bash {
	package { "bash":
		ensure => present,
		allowcdrom => true,
	}
	file { "/root/.bashrc":
		owner => root,
		group => root,
		mode => 600,
		source => "puppet://puppet/files/root/.bashrc",
		require => Package["bash"]
	}
	package { "bash-completion":
		ensure => present,
		allowcdrom => true,
	}
}

class apticron {
	package { "apticron":
		ensure => present,
		allowcdrom => true
	}
}

class logcheck {
	package { "logcheck":
		ensure => absent,
		allowcdrom => true
	}
}

class logwatch {
	package { "logwatch":
		ensure => present,
		allowcdrom => true
	}
}

class ssh {
	package { "openssh-server":
		ensure => present,
		allowcdrom => true,
	}

	ssh_authorized_key{ "rodney-windows-home":
		ensure => present,
		key => "AAAAB3NzaC1yc2EAAAABJQAAAIEA4usKhH6RNghf72lFbJNIHZOQB9YackGfJFW45EK03HMhhgoQkZd4lB6CZmybcV1NHsa5P4gC4FD555QLniFLC3Z/qRYVQFDJpL6ISaCpuop2DWzu6SUz4KLSYk0pfQ2+zzPqX6dfM8neL0OmS+Oz4jTI/iC5QwOjgLK6d+AZhJk=",
		type => "ssh-rsa",
		user => "root"
	}

	ssh_authorized_key{ "rodney-macbook":
		ensure => present,
		key => "AAAAB3NzaC1yc2EAAAABJQAAAQEAuHykU4qcf4UAFzXG4LPp+ulYY3gCNoOiyUe9Nko+02a+FW/jKkw2ZDoRBhBFzv5kprXyxT+3TvEM2+6T/+aNwCn3vnvNLB21TA/G4CyeSeuHq9VCUxBY5DYrbIB/ZlhHzGjWR8ryaxi2eO7jlN3S7KIk7LVtw0ThK4v+w1zqCcS3eEmtl2m8kfs62ofJ4xtBTWrHHA+2WMb5qDnx6h4oUu18DoFpg2iPZS5pS6It0AxvIgCMJ+63o3YGkQvYKXrAlK9h3XqJU3AEOnkvvkITwdRAXmCH2BFRLErj8MfNyEvIv41XhAP8LITrgBctxSf5zDlPFy37jp4XSt65OgQhDQ==",
		type => "ssh-rsa",
		user => "root"
	}
}

class mail::aliases {
	file { "/etc/aliases" :
	  mode => 644,
	  owner => "root",
	  group => "root",
	  alias => 'aliases';
	}

	exec { "newaliases" :
	  command => "/usr/bin/newaliases",
	  refreshonly => true,
	  subscribe => File['aliases'];
	} 
	mailalias { "root":
		recipient => "rodnet+server-$hostname@gmail.com",
		ensure => present
	}
}



node basenode {
	include vim, bash, ssh, less, rsync, apticron, logcheck, mail::aliases
}

