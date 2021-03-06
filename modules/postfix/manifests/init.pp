class postfix::standard {
    package { "postfix":
        ensure => "present",
    }
    service { "postfix":
        ensure => "running",
        enable => true,
        require => Package["postfix"]
    }

    file { "/etc/postfix/main.cf":
        owner => "root",
        group => "root",
        mode => 0644,
        content => template("postfix/main.cf.erb"),
        require => Package["postfix"],
        notify => Service["postfix"]
    }
}