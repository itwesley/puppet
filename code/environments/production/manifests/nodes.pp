# Use class, Don't Repeat Yourself (DRY).
class linux {

  $admintools = ['git', 'ntp', 'screen', 'nano', 'tree', 'wget']

  # package pattern
  package { $admintools:
    ensure => 'installed',
  }

  # Use selector variable
  $ntpservice = $osfamily ? {
    'redhat' => 'ntpd',
    'debian' => 'ntp',
    default  => 'ntp',
  }

  # file pattern
  file { '/info.txt':
    ensure => 'present',
    content => inline_template("Created by Puppet at <%= Time.now %>\n"), # ERB - Embedded Ruby Block.
  }

  # service pattern
  service { $ntpservice:
    ensure => 'running',
    enable => true,
  }


}


# wiki is centos
node 'wiki' {

  # Replaced by hiera, so mark below:
  #$wikisitename = 'wiki'
  #$wikimetanamespace = 'Wiki'
  #$wikiserver = 'http://172.31.0.202'
  #$wikidbname = 'wiki'
  #$wikidbuser = 'root'
  #$wikidbpassword = 'training'
  #$wikiupgradekey = 'puppet'

  # Replaced by hiera, so mark below:
  #class { 'linux': }
  #class { 'mediawiki': }

  # Use hiera
  hiera_include('classes')

}


# wikitest is ubuntu
node 'wikitest' {
 
  # Replaced by hiera, so mark below:
  #$wikisitename = 'wikitest'
  #$wikimetanamespace = 'Wikitest'
  #$wikiserver = 'http://172.31.0.203'
  #$wikidbname = 'wiki'
  #$wikidbuser = 'root'
  #$wikidbpassword = 'training'
  #$wikiupgradekey = 'puppet'

  # Replaced by hiera, so mark below:
  #class { 'linux': }
  #class { 'mediawiki': }

  # Use hiera
  hiera_include('classes')

}
