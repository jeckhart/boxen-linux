class projects::dev {
  #require projects::yodlecore

  package { "tomcat":
    ensure => present,
  }

  package { "jetty":
    ensure => present,
  }

  package { "thrift":
    ensure => present,
  }

  package { "selenium-server-standalone":
    ensure => present,
  }

}
