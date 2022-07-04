class nagioskms::nagios_host(
  Array[String] $nrpe_arr
){ 
    $pkg_arr = ["epel-release", "nagios-plugins-nrpe"]

    package{$pkg_arr:
      ensure => "installed"
    }
    file {'/usr/local/nagios/etc/puppet' :
      ensure => 'directory',
      owner => 'nagios'
    }

    file_line{'puppet-cfg':
      ensure => 'present',
      path => '/usr/local/nagios/etc/nagios.cfg',
      line => 'cfg_dir=/usr/local/nagios/etc/puppet'
    }

    file{'/usr/local/nagios/etc/puppet/nagios_command.cfg':
      ensure => 'file',
      owner => 'nagios',
      content => ''
    }
    
    file{'/usr/local/nagios/etc/puppet/nagios_service.cfg':
      ensure => 'file',
      owner => 'nagios',
      content => ''
    }

    file{'/usr/local/nagios/etc/puppet/nagios_host.cfg':
      ensure => 'file',
      owner => 'nagios',
      content => ''
    }

    nagios_command{'check_nrpe':
      ensure => 'present',
      target => '/usr/local/nagios/etc/puppet/nagios_command.cfg',
      command_name => 'check_nrpe',
      command_line => '/usr/lib64/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c $ARG1$'
    }


    $nrpe_arr.each |String $nrpe_client_ip| {
      nagios_host{'host':
        target => '/usr/local/nagios/etc/puppet/nagios_host.cfg',
        ensure => 'present',
        use => "linux-server",
        host_name => $nrpe_client_ip,
        address => $nrpe_client_ip,
      }

      nagios_service{'nginx_service':
        target => '/usr/local/nagios/etc/puppet/nagios_service.cfg',
        ensure => 'present',
        use => 'local-service',
        host_name => $nrpe_client_ip,
        service_description => "Check nginx status",
        check_command => "check_nrpe!check_nginx"
      }
      
      nagios_service{'disk_service':
        target => '/usr/local/nagios/etc/puppet/nagios_service.cfg',
        ensure => 'present',
        use => 'local-service',
        host_name => $nrpe_client_ip,
        service_description => "Check Disk Health",
        check_command => "check_nrpe!check_disk_usage"
      }
    }

    exec{'restart-nagios':
      command => '/bin/systemctl restart nagios',

    }

    
}
