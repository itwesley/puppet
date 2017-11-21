# Replacing by Defined Type (ntp::admin_file)
#class ntp::config (
#  $location = 'london',
#  $admingroup = $ntp::params::admingroup, 
#) inherits ntp::params {

class ntp::config ($location = 'london',) {
  
  $valid_location = [
    '^london$',
    '^taipei$',
  ] 

  validate_legacy('String', 'validate_re', $location, $valid_location)

  # The case statement has replaced due to inherit ntp::params class.
  #case $facts['os']['family'] {
  #  'RedHat': { 
  #    $admingroup = 'wheel' 
  #  }
  #  'Debian': { 
  #    $admingroup = 'sudo' 
  #  }
  #  'Default': { fail("Oops, OS is unknown.") }
  #}

  # Replacing by Defined Type (ntp::admin_file)
  #File {
  #  ensure => 'file',
  #  owner  => 'root',
  #  group  => $admingroup,
  #  mode   => '0644', 
  #}
  #
  #file { '/etc/ntp.conf':
  #  content =>  file("ntp/$location"),
  #  notify  =>  Class['ntp::service'],
  #}

  # This is a Defined Type (ntp::admin_file)
  ntp::admin_file { '/etc/ntp.conf': 
    #ntp_location => $location, 
    ntp_location  => 'taipei', 
    monitor       =>  true,
  }

}
