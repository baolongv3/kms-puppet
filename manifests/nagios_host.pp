class nagioskms::nagios_host{ 

    file { '/etc/nagios' :
      ensure => 'link',
      target => '/usr/local/nagios'
    }

    nagios_command{'check_nrpe':
      ensure => 'present'
      command_name => 'check_nrpe'
      command_line => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$'

    }
}
