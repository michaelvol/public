
class guardicore-honeypot {

  exec { 'download datapath':
    command => '/usr/bin/curl --insecure https://10.0.1.184:8000/repos/datapath.tar.gz -o /tmp/datapath.tar.gz',
    logoutput => true,
  }

  exec { 'extract datapath': 
    command => '/bin/tar xzvf /tmp/datapath.tar.gz -C /var/lib',
    require => Exec["download datapath"],
    logoutput => true,
  }

  exec { 'setup.sh': 
    #path => '/var/lib/guardicore/datapath/scripts/openstack/Havana',
    #command => "setup.sh install 127.0.0.1 --local",
    command => "/var/lib/guardicore/datapath/scripts/openstack/Havana/setup.sh install 10.0.1.184 --local",
    timeout => 0,
    require => Exec["extract datapath"],
    logoutput => true,
    provider => shell
  }

}
