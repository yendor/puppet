class user::unixadmins inherits user::virtual {
	include sudo
	include sshd-config

	realize(
		User["rodney.amato"],
		Ssh_authorized_key["rodney-windows-home"],
		Ssh_authorized_key["rodney-macbook"],
		Ssh_authorized_key["rodney-testkey"],
		User["chris.boulton"],
	)

}
