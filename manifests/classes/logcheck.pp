class logcheck {
    package { "logcheck":
        ensure => absent,
        allowcdrom => true
    }
}

