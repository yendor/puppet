class logwatch {
    package { "logwatch":
        ensure => present,
        allowcdrom => true
    }
}


