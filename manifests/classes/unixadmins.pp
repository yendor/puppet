class user::unixadmins inherits user::virtual {
	include sudo

	realize(
		User["rodney.amato"],
		Ssh_authorized_key["rodney-windows-home"],
		Ssh_authorized_key["rodney-macbook"],
		Ssh_authorized_key["rodney-testkey"],
		Ssh_authorized_key["rodney-work"],
		User["chris.boulton"],
	)

}
