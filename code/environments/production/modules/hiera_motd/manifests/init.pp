class hiera_motd (
  $message = "This is a hiera motd practice.\n"
) {

  file { '/etc/motd':
    ensure  => 'file',
    content => $message,
  }

} 
