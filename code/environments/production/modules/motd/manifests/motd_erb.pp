$down_time = '23:00'

$motd_msg = @(END)
The server <%= @facts['networking']['fqdn'] %> will shutdown at <%= @down_time %>
END

file { '/etc/motd':
  ensure  => 'file',
  content => inline_template($motd_msg),
}
