class nagioskms::nagios_host{ 

    file { '/etc/nagios' :
      ensure => 'link',
      target => '/usr/local/nagios'
    }

}
