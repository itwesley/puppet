class ntp ( $ntp_location = 'london' ) {
 
  package { 'ntp':
    ensure  => 'present',
    before  => Class['ntp::config'],
  }

  # pass parameter to ntp::config class
  class { ntp::config: 
    #location => 'london', 
    location => $ntp_location, 
    #location => 'paris', 
  }

  #include ntp::config

  include ntp::service
  
}
