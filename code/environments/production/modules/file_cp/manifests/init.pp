class file_cp {

  file { '/etc/dhcp/':
    ensure  => 'present',
    source  => 'puppet:///modules/file_cp/dhcp', # Note: Don't add 'files' between 'file_cp/' and '/dhcp'.
    recurse =>  true,
    purge   =>  true, # remove files if files in destination(/etc/dhcp/) are not existence in source.
  }

}
