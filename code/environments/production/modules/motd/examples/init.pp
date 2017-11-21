#include ::motd

# pass motd_msg parameter to class motd.
# (At motd/manifests/init.pp)
class { 'motd':

  # This is default value at class motd.
  #motd_msg => 'Daily', 

  motd_msg => 'Weekly',

}
