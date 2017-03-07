class nginx_proxy (
  String $master_ip,
  String $package = $nginx_proxy::params::package,
  String $service = $nginx_proxy::params::service,
  String $config_path = $nginx_proxy::params::config_path,
  String $config_file = $nginx_proxy::params::config_file,
) inherits nginx_proxy::params  {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  file { $config_path:
    ensure => directory,
  }
  file { "${config_path}/${config_file}":
    ensure  => file,
    content => epp('nginx_proxy/default.conf.epp', { master_ip => $master_ip }),
  }
  package { $package:
    ensure => latest,
    before => File[$config_path, "${config_path}/${config_file}"],
  }
  service { $service:
    ensure  => running,
    enable  => true,
    require => Package[$package],
  }
}
