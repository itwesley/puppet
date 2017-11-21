# custom defined type without parameter
#define ntp::admin_file {
# custom defined type with parameter
define ntp::admin_file (
  $ntp_location = 'london',
  $monitor = false,
) {

  include ntp::params
 
  $admingroup = $ntp::params::admingroup

  $ntp_regional_server = $ntp_location ? {
    'london' => ['uk.pool.ntp.org','us.pool.ntp.org'],
    'taipei' => ['tw.pool.ntp.org', 'time.stdtime.gov.tw'],
    default => 'pool.ntp.org',
  }

  file { $title:
    #content => file('ntp/ntp.conf'),
    #content => file("ntp/$ntp_location"),
    # For ERB
    #content => template('ntp/ntp.conf.erb'),
    # For EPP (EPP can send parameter to .epp file)
    content =>  epp('ntp/ntp.conf.epp', { 'ntp_regional_server' => $ntp_regional_server, 'monitor' => $monitor, }, ),
    owner   => 'root',
    group   => $admingroup,
    mode    => '0644',
    ensure  => 'file',
    notify  => Class['ntp::service'],
  }

}
