class ntp::service (
$ntp_service = $ntp::params::ntp_service, 
) inherits ntp::params {

  # The case statement has replaced due to inherit ntp::params class.
  #case $facts['os']['family'] {
  #  'RedHat': { 
  #    $ntp_service = 'ntpd'
  #  }
  #  'Debian': { 
  #    $ntp_service = 'ntp'
  #  }
  #  'Default': { fail("Oops, OS is unknown.") }
  #}

  service { $ntp_service:
    ensure    => 'running',
    enable    => true,
    subscribe => Class['ntp::config'],
  }

}
