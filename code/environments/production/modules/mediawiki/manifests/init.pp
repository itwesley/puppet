# Class: mediawiki
# ===========================
#
# Full description of class mediawiki here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'mediawiki':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class mediawiki {
  
  # Use hiera to help your .pp file more clearly.
  $wikisitename = hiera('mediawiki::wikisitename')
  $wikimetanamespace = hiera('mediawiki::wikimetanamespace')
  $wikiserver = hiera('mediawiki::wikiserver')
  $wikidbname = hiera('mediawiki::wikidbname')
  $wikidbuser = hiera('mediawiki::wikidbuser')
  $wikidbpassword = hiera('mediawiki::wikidbpassword')
  $wikiupgradekey = hiera('mediawiki::wikiupgradekey')

  $phpmysql = $osfamily ? {
      'redhat' => 'php-mysql',
      'debian' => 'php5-mysql',
      default  => 'php-mysql',
  }
  
  package { $phpmysql:
    ensure => 'present',
  }
  
  if $osfamily == 'redhat' {
    package { 'php-xml':
      ensure => 'present',
    }
  }
  
  class { '::apache':
    docroot    => '/var/www/html',
    mpm_module => 'prefork',
    subscribe  => Package[$phpmysql],
  }
  
  class { '::apache::mod::php': }

  vcsrepo { '/var/www/html':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/wikimedia/mediawiki.git',
    revision => '1.24.6',
  }

  file { '/var/www/html/index.html':
    ensure => 'absent',
  }
 
  file { 'remove-mediawiki-skins': 
    path    => '/var/www/html/skins',
    ensure  => 'absent',
    recurse => true,
    force   => true,
    purge   => true,
    replace => no,
  }

  vcsrepo { '/var/www/html/skins/MonoBook':
    ensure   => 'present',
    provider => git,
    source   => 'https://github.com/wikimedia/mediawiki-skins-MonoBook.git',
    revision => 'REL1_24',
  }

  # Resource ordering - execute File resource after Vcsrepo resource
  File['/var/www/html/index.html'] -> Vcsrepo['/var/www/html'] -> File['remove-mediawiki-skins'] -> Vcsrepo['/var/www/html/skins/MonoBook']

  class { '::mysql::server':  
    root_password => 'training',
  }

  class { '::Firewall': }

  #firewall { '000 accept all http':
  #  ensure => 'absent',
  #  dport   => '80',
  #  proto  => 'tcp',
  #  action => 'accept',
  #}

  firewall { '000 accept all http/https':
    dport   => [80, 443],
    proto  => 'tcp',
    action => 'accept',
  }
  
  # Use template 
  file { 'LocalSettings.php':
    path => "/var/www/html/LocalSettings.php",
    ensure => 'file',
    content => template('mediawiki/LocalSettings.erb'),
  }

}
