class mail::aliases {
    file { "/etc/aliases" :
      mode => 644,
      owner => "root",
      group => "root",
      alias => 'aliases'
    }

    exec { "newaliases" :
      command => "/usr/bin/newaliases",
      refreshonly => true,
      subscribe => File['aliases']
    }

    mailalias { "root":
        recipient => "rodnet+server-$hostname@gmail.com",
        ensure => present
    }
}

