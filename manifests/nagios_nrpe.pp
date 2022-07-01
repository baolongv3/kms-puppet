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
      ensure => 'present',
      content => template('nagioskms/scripts/check_nginx')
    }

    nrpe::plugin{'check_disk_usage':
      ensure => 'present',
      content => template('nagioskms/scripts/check_disk_usage')
    }

    nrpe::command{'check_nginx':
      ensure => 'present',
      command => 'check_nginx localhost'
    }

    nrpe::command{'check_disk_usage':
      ensure => 'present',
      command => 'check_disk_usage -w 40 -c 60'
    }


}
