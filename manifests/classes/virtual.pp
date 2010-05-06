class user::virtual {
    @user { "root":
		ensure	=> present,
		uid		=> "0",
		gid		=> "root",
		comment	=> "Root User",
		home	=> "/root",
		shell	=> "/usr/bin/rootsh",
		managehome => "true",
		require => Package["rootsh"]
	}

	@user { "rodney.amato":
		ensure	=> present,
		uid		=> "5001",
		gid		=> "users",
		comment	=> "Rodney Amato",
		home	=> "/home/rodney.amato",
		shell	=> "/bin/bash",
		groups	=> ["sudo", "adm"],
		managehome => "true"
	}

	@ssh_authorized_key{ "rodney-windows-home":
		ensure => present,
		key => "AAAAB3NzaC1yc2EAAAABJQAAAIEA4usKhH6RNghf72lFbJNIHZOQB9YackGfJFW45EK03HMhhgoQkZd4lB6CZmybcV1NHsa5P4gC4FD555QLniFLC3Z/qRYVQFDJpL6ISaCpuop2DWzu6SUz4KLSYk0pfQ2+zzPqX6dfM8neL0OmS+Oz4jTI/iC5QwOjgLK6d+AZhJk=",
		type => "ssh-rsa",
		user => "rodney.amato",
	}

	@ssh_authorized_key{ "rodney-macbook":
		ensure => present,
		key => "AAAAB3NzaC1yc2EAAAABJQAAAQEAuHykU4qcf4UAFzXG4LPp+ulYY3gCNoOiyUe9Nko+02a+FW/jKkw2ZDoRBhBFzv5kprXyxT+3TvEM2+6T/+aNwCn3vnvNLB21TA/G4CyeSeuHq9VCUxBY5DYrbIB/ZlhHzGjWR8ryaxi2eO7jlN3S7KIk7LVtw0ThK4v+w1zqCcS3eEmtl2m8kfs62ofJ4xtBTWrHHA+2WMb5qDnx6h4oUu18DoFpg2iPZS5pS6It0AxvIgCMJ+63o3YGkQvYKXrAlK9h3XqJU3AEOnkvvkITwdRAXmCH2BFRLErj8MfNyEvIv41XhAP8LITrgBctxSf5zDlPFy37jp4XSt65OgQhDQ==",
		type => "ssh-rsa",
		user => "rodney.amato"
	}

	@ssh_authorized_key{ "rodney-testkey":
		ensure => present,
		key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA1SMY7G35MWy9JNKtLYjtNU1gzsCnOU/FvRjC7QOnu5fnV5WVONZJIkZKAw4ZSaEDZxk0vh13eVUuSSzrUBoSEKwAEhwVIYlNr5t8pDs7sZKLzNGLcEIBjlWtIDj5TsbMHEw4ZqAYnfb64vPLP/lH76/n15xigw5c31sTOsWDY6kmpRqzuqYzvuhub9+lxBkOQEWCu3II/LGwxlmLPamktPb3wDcj6zqSifeyfpeq1tVuJmy+kmjKyelG2VAQdGAQjuEj8Rq0uHO5HffyV+QJ5BL4RnkzSaV2uLQzYS85G+0Opbg07JqhkowZU0wJCIcM/YpJKtcjo/6pp5GKllx9Uw==",
		type => "ssh-dss",
		user => "rodney.amato"
	}

	@user { "chris.boulton":
		ensure	=> absent,
		uid		=> "5002",
		gid		=> "users",
		comment	=> "Chris Boulton",
		home	=> "/home/chris.boulton",
		shell	=> "/bin/bash",
		groups	=> ["sudo"],
		managehome => "true"
	}
}
