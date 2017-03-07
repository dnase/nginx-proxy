class nginx_proxy::params {
  $package = 'nginx'
  $service = 'nginx'
  case $::osfamily {
    'debian': {
      $config_path = '/etc/nginx/sites-enabled'
      $config_file = 'default'
    }
    'redhat': {
      $config_path = '/etc/nginx/conf.d'
      $config_file = 'default.conf'
    }
    default: {
      fail("Error! Unsupported OS: ${::osfamily}")
    }
  }
}
