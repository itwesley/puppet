#$down_time = '17:00'

$motd_msg = @(END)
The server <%= $facts['networking']['fqdn'] %> will shutdown at <%= $down_time %>
END

file { '/etc/motd':
  ensure  => 'file',
  #content => inline_epp($motd_msg),
  content => inline_epp($motd_msg, {'down_time' => '19:00'},),
}
