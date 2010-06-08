class logwatch {
    package { "logwatch":
        ensure => absent,
        allowcdrom => true
    }
}


