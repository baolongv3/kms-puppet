class nagioskms::nagios_nrpe(
  Array[String] $host_arr
){ 
    package{'epel-release':
      ensure => 'present'
    }

    class{'nrpe':
      allowed_hosts => $host_arr
    }

    nrpe::plugin {'check_nginx':
      ensure => 'present'
    }
}
