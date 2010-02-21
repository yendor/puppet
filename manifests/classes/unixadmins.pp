class user::unixadmins inherits user::virtual {
	include sudo
	realize(
		User["rodney.amato"],
		Ssh_authorized_key["rodney-windows-home"],
		Ssh_authorized_key["rodney-macbook"],
		User["chris.boulton"],
	)

}
