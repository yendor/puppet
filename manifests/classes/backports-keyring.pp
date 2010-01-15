class backports-keyring {
	include wget
	exec { "install-backports-key" :
		command => "/usr/bin/wget -O - http://backports.org/debian/archive.key | /usr/bin/apt-key add -",
		require => Package["wget"],
		unless => "/usr/bin/apt-key list | /bin/grep -q 'Backports.org Archive Key <ftp-master@backports.org>'",
	}
}

