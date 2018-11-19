# PE Backups configured on cron

class profile::puppet_server::backup (
  String[1] $backup_command   = '/opt/puppetlabs/bin/puppet-backup create',
  String[1] $backup_script    = '/opt/puppetlabs/bin/puppet-backup-script.sh',
  String[1] $dir              = '/var/puppetlabs/backups',
  String[1] $name_prefix      = 'pe-backup',
  String[1] $date_format      = '+%Y%m%d%H%M%S',
  Optional[Hash] $cron_config = lookup('profile::puppet_server::backup::cron_config'),
){
  Resource['cron'] {
    backup_pe: * => { 'command' => $backup_script };
    default: * => $cron_config;
  }
  file { $backup_script:
    ensure  => file,
    mode    => '0500',
    owner   => 'root',
    content => "${backup_command} --dir ${dir} --name=${name_prefix}-\$(date ${date_format}).tgz"
  }
}
