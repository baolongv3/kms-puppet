# This is the structure of a simple plan. To learn more about writing
# Puppet plans, see the documentation: http://pup.pt/bolt-puppet-plans

# The summary sets the description of the plan that will appear
# in 'bolt plan show' output. Bolt uses puppet-strings to parse the
# summary and parameters from the plan.
# @summary A plan created with bolt plan new.
# @param targets The targets to run on.
# plan nagioskms::nagios (
#   TargetSpec $nagios_host = "localhost"
#   # TargetSpec $nagios_nrpe_client "localhost"
# ) {
  
# }

plan nagioskms::nagios () {
  $web_arr = get_targets('nagios-kms-web').map |$host| {$host.uri}
  apply_prep('all')
  apply('nagios-kms-web'){
    include nagioskms::nagios_host
  }

  apply('nagios-kms-nrpe'){
    class{'nagioskms::web':
      host_arr => $web_arr

    }
  }
}
