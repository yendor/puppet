class rsync {
    package { "rsync":
        ensure => present,
        allowcdrom => true,
    }
}

