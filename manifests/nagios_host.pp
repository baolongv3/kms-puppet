class nagioskms::nagios_host{
  yumrepo{'nagios-repo':
    url => "https://repo.nagios.com/nagios"
  }
}
