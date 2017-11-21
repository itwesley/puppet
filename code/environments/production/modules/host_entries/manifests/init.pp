class host_entries {

    host { 'localhost':
      ip => '127.0.0.1',
    }

    host { $facts['networking']['fqdn']:
      ip => $facts['networking']['interfaces']['eth1']['ip'],
    }

    host_entries::host_entry { 'puppetmaster':
      ip => '172.31.0.201',
    }

    host_entries::host_entry { 'wiki':
      ip => '172.31.0.202',
    }

    host_entries::host_entry { 'wikitest':
      ip => '172.31.0.203',
    }

    # meta-resource: it can manage meta-parameters for the given resouce type.
    resources { 'host':
      purge => true,
    }

}
