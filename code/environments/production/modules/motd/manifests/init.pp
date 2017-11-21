class motd ( $motd_msg = 'Daily' ) {

  $valid_files = [
    '^Daily$',
    '^Weekly$',
  ]

  # deprecated
  #validate_re( $motd_msg, $valid_files )

  validate_legacy('String', 'validate_re', $motd_msg, $valid_files )
  
  file { '/etc/motd':
    ensure  => 'present',
    content => file("motd/$motd_msg"),
  }

  # Test custom resource type (myfile)
  myfile { '/tmp/a.txt':
    ensure => 'present',
    #ensure => 'absent',
  }

}
