
class guardicore-honeypot (
  $mgmt_ip = undef,
  $dp_download_ip_and_port = undef,
) {

  exec { 'download datapath puppet client':
    command => "/usr/bin/curl --insecure https://${dp_download_ip_and_port}/repos/datapath_puppet_client.py -o /tmp/datapath_puppet_client.py",
    logoutput => true,
  }

  exec { 'datapath puppet client': 
    command => "python /tmp/datapath_puppet_client.py -u https://{dp_download_ip_and_port}/repos/datapath.tar.gz -m ${mgmt_ip}",
    timeout => 0,
    require => Exec["download datapath puppet client"],
    logoutput => true,
    provider => shell
  }

}
