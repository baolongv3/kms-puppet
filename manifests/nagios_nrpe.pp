class nagioskms::nagios_nrpe{ 

    $requiredPkg = ['nagios-plugins-all','nagios-plugins-nrpe','nrpe']
    package{ $requiredPkg:
      ensure : 'installed'
    }

    package{ 'nginx':
    

    }
}
