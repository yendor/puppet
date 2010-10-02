class vim {
    package { "vim":
        ensure => present,
        allowcdrom => true,
    }
    file { "/root/.vimrc":
        owner => root,
        group => root,
        mode => 600,
        source => "puppet:///files/root/.vimrc",
        require => Package["vim"]
    }
}

