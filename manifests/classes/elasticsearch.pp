class elsaticsearch {
  include git
  package { "openjdk-6-jre-headless":
    ensure => present,
  }
  
  file { "/etc/elasticsearch":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => 0755,
    backup => false,
  }
  
  file { "/etc/elasticsearch/elasticsearch.yaml":
    source => "puppet:///files/elasticsearch/elasticsearch.yaml",
    owner  => "root",
    group  => "root",
    mode   => 0644,
    backup => false,
    require => File["/etc/elasticsearch"]
  }
  
  file { "/etc/init.d/elasticsearch":
    source => "puppet:///files/elasticsearch/elasticsearch.init",
    owner  => "root",
    group  => "root",
    mode   => 0755,
    backup => false,
  }
}