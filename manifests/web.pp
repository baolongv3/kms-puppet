class nagioskms::web(
  Array[String] $host_arr
) {

  class{'nagioskms::nagios_nrpe':
    host_arr => $host_arr
  }
  
  package{'nginx':
    ensure => "installed"
  }

  service{'nginx':
    name => "nginx",
    ensure => "running",
    
  }

}
