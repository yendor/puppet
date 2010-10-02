class bash {
    package { "bash":
        ensure => present,
        allowcdrom => true,
    }
    file { "/root/.bashrc":
        owner => root,
        group => root,
        mode => 600,
        source => "puppet:///files/root/.bashrc",
        require => Package["bash"]
    }
    package { "bash-completion":
        ensure => present,
        allowcdrom => true,
    }
}

