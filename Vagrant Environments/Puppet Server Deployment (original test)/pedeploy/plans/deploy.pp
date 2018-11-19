#vagrant up ; bolt plan run pedeploy::deploy --user vagrant --password vagrant --modulepath . installer_tarball='c:\temp\puppet-enterprise-2018.1.4-el-7-x86_64.tar.gz' pe_conf='c:\temp\pe.conf' -n 10.0.0.10 --no-host-key-check r10k_key="c:\temp\id_rsa_r10k" 
# ... assumes a pe_conf is available for upload'

plan pedeploy::deploy(
  String[1] $installer_tarball,
  String[1] $installer_tarball_remote  ='/tmp/installer.tar.gz',
  String[1] $pe_conf,
  String[1] $pe_conf_remote  ='/tmp/pe.conf',
  String[1] $r10k_key,
  String[1] $r10k_key_remote  ='/etc/puppetlabs/r10k/id_rsa_r10k',
  TargetSpec $nodes,
  
){
  upload_file($installer_tarball, $installer_tarball_remote, $nodes)#'_run_as' => 'root')
  upload_file($pe_conf, $pe_conf_remote, $nodes)#'_run_as' => 'root')
  #apply()
  run_command("mkdir -p /etc/puppetlabs/r10k/", $nodes, '_catch_errors' => true,'_run_as' => 'root' )
  
  upload_file($r10k_key, $r10k_key_remote, $nodes, '_run_as' => 'root')
  run_command('rm -rf /tmp/puppetserver ; mkdir -p /tmp/puppetserver', $nodes, '_catch_errors' => true,'_run_as' => 'root' ) #
  run_command("tar -zxvf ${installer_tarball_remote} -C /tmp/puppetserver --strip-components=1", $nodes, '_catch_errors' => true,'_run_as' => 'root' )
  run_command("/tmp/puppetserver/puppet-enterprise-installer -c \"${pe_conf_remote}\"", $nodes, '_catch_errors' => true,'_run_as' => 'root' )

}
