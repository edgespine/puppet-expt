class profile::linux::apache (
  String[1] $php_version    = lookup('profile::linux::php::php_version'),
  String[1] $apache_version = lookup('profile::linux::apache::apache_version'),
  String[1] $serveradmin    = lookup('profile::linux::apache::serveradmin'),
  String[1] $vhost_dir      = lookup('profile::linux::apache::vhost_dir'),
){
  class { 'apache' :
    # Name of the apache package to install
    apache_version => $apache_version,
    apache_name => 'httpd',

    # Set the name of the error log file
    error_log => 'error_log',

    # Set the name of the access log file
    access_log_file => 'access.log',

    default_vhost => true,
    confd_dir => '/etc/httpd/conf.d',
    docroot => '/var/www/html',
    user => 'apache',
    group => 'apache',
    timeout => '120',
    keepalive => 'On',
    keepalive_timeout => '15',
    max_keepalive_requests => '100',
    lib_path => '/usr/lib64/httpd/modules/',
    log_level => 'warn',
    logroot => '/var/log/httpd/',
    mod_dir => '/etc/httpd/conf.modules.d',
    pidfile => 'run/httpd.pid',
    servername => $hostname,
#   serveradmin => 'ict-unixadmin-dl@imperial.ac.uk',
    serveradmin => $serveradmin,
    server_root => '/etc/httpd',
    server_tokens => 'Prod',
    server_signature => 'Off',
    file_e_tag => 'None',
    service_enable => true,
    service_ensure => true,
    service_manage => true,
    use_canonical_name => 'Off',

    # Installs systemd module
    use_systemd => 'true',

    # File permissions for config files
    file_mode => '644',

    # Root directory options
    root_directory_options => ['FollowSymLinks'],

    # Root directory security policy
    root_directory_secured => true,

    # Set the vhost directory
    vhost_dir => $vhost_dir,

    # Set the vhost include pattern
    vhost_include_pattern => '*.conf',

    # Set script alias
    scriptalias => '/var/www/cgi-bin/',

    # Set the max number of request header fields in a HTTP request
    limitreqfields => '100',
  }

  class { '::apache::mod::php':
    package_name => 'php-common',
    php_version  => $php_version,
    path         => 'modules/libphp7.so',
    require      => Package['php', 'php-opcache'],
  }

  # Create resources from hiera data...
  # https://puppet.com/docs/puppet/5.5/lang_resources_advanced.html#implementing-the-createresources-function
  $sites=lookup('profile::linux::apache::sites')
  $sites.each|String $site, Hash $site_resources| {
    notify {"Managing site: ${site} - containing resources: ${site_resources}":}
    $site_resources.each|String $type, Hash $resources|{
      notify {"Managing  site ${site} resource type: ${type} - containing resources: ${resources}":}
      $resources.each|String $title, Hash $attributes|{
        notify {"Managing site resource: ${title} - containing resource attributes: ${attributes}":}
        Resource[$type] { $title:
          * => $attributes,
        }
      }
    }

  }

}
