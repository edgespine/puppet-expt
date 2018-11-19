/* vagrant up ; bolt plan run pedeploy::deploy --user vagrant --password vagrant --modulepath . installer_tarball='C:\temp\puppet-enterprise-2018.1.4-el-7-x86_64.tar.gz' pe_conf='D:\Puppet\puppet_server_deployer\pedeploy\files\pe.conf' -n 10.0.0.10 --no-host-key-check r10k_key="D:\Puppet\puppet_server_deployer\pedeploy\files\id_rsa_r10k" 
§... assumes a pe_conf is available for upload'

Example (bash):
R10K key needs to not be a single line variable.

PE_CONF_CONTENT='{
"console_admin_password": "puppet",
"puppet_enterprise::puppet_master_host": "%{::trusted.certname}",
"puppet_enterprise::profile::master::r10k_private_key": "/etc/puppetlabs/r10k/id-control_repo.rsa",
"puppet_enterprise::profile::master::r10k_remote": "git@github.com:ImperialCollegeLondon/puppet-control-repo-ict.git",
"puppet_enterprise::profile::master::code_manager_auto_configure": true,
"pe_install::puppet_master_dnsaltnames": ["icpuppetmaster.cc.ic.ac.uk"],
}'
R10K_KEY_CONTENT='-----BEGIN RSA PRIVATE KEY-----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-----END RSA PRIVATE KEY-----'
TARGET='10.0.0.10'
MODULEPATH='../'
INSTALLER_TARBALL='/tmp/pe_deployer_files/puppet-enterprise-2018.1.5-el-7-x86_64.tar.gz'

bolt plan run puppet_server_deployer::deploy --user root --password vagrant --run_as root -n $TARGET --no-host-key-check --modulepath $MODULEPATH \
  installer_tarball="$INSTALLER_TARBALL" pe_conf_content="$PE_CONF_CONTENT" r10k_key_content="\'$R10K_KEY_CONTENT\'"

Example (powershell):
R10K key needs to not be a single line variable.

$env:PE_CONF_CONTENT='{
\"console_admin_password\": \"puppet\",
\"puppet_enterprise::puppet_master_host\": \"%{::trusted.certname}\",
\"puppet_enterprise::profile::master::r10k_private_key\": \"/etc/puppetlabs/r10k/id-control_repo.rsa\",
\"puppet_enterprise::profile::master::r10k_remote\": \"git@github.com:ImperialCollegeLondon/puppet-control-repo-ict.git\",
\"puppet_enterprise::profile::master::code_manager_auto_configure\": true,
\"pe_install::puppet_master_dnsaltnames\": [\"icpuppetmaster.cc.ic.ac.uk\", \"icpuppm.cc.ic.ac.uk\", \"icpupplb.cc.ic.ac.uk\", \"icpuppcm1.cc.ic.ac.uk\", \"icpuppcm2.cc.ic.ac.uk\", \"icpuppcm3.cc.ic.ac.uk\", \"icpuppcm4.cc.ic.ac.uk\"],
}'
$env:R10K_KEY_CONTENT='-----BEGIN RSA PRIVATE KEY-----
MIIJKAIBAAKCAgEAvuihYxPtnW4XfAGHsLsWE8A2aFKcU/RBjGU/fE7AU2xZGRUk
rhEkwKdrEuz4hWseOJMkUv0HakKgG4Sx3Qs4sZqHr7Y6Vrh2qKtEPSxA3pejMz5x
sqrEqqZO7r7vQjFZc48N/PWyBKuo7HiBCJ7xWQXu5zE/B5Va87JeVqABMdPXkzaE
Ig5+sh1r2HsKUhzMtW8tellE3/5HzbB+nfIbtuTG9mbJRstwWbRP8x/DSkMKMOjC
sWme/Zste0MJRe1521l5MQqdZRsMzqlsC8uNyPTTqOz80kI9aJapc/2PL8xd29Vi
ipZVob2Mg1kw+i7a7nR7WHtOglK2m2Rn5BZuRu5eA8PaCNjNuvHZx0FeT+lKb2sd
zSTDJisbAZTpW4HYm5MBAw5Nuoz6q0k+F9RfI4O4tah07QaFYcD8qDbRGSJjszoe
1qJyY523bWRmuVaX73lL8qgDwEuFizCzmaEvkwentUH7RenzB/nQwddHE1OGPUZI
a9MSW49nswN63z/y9Tm4+y3T5i6YdnHSWxN8q80tslVDZdguEYFZp3p2erKMDsHm
o3gnS/j8ciclUlwOe7EEm/mLdd0f/04KgArcsA0UCdQNSbn+gU3YElnNNnNXb+sY
6V/IGxGVUHdMhTyei/vQqf5CAh8IpqIkwGl5goUbnmc0Ec9eXwTGs+oSzcUCAwEA
AQKCAgEAlV6Ur12vQ8cYrtjPnxKycl+o8jT4xaNOChhJ9Ov1BRC4IazuVxdoxyf2
2gb5aAJo0eEmwZviSly4wu8u7wFRqXx7/5o3yRRpGw1txeMzGjZQ5c5MzXtZhx+6
kIhp0UOldooOasaeM5NQBz090E30DjBbPR7F7xwH3rbHo0Vryd2zRSaZecAXlyr3
75hNefO4o5jKX3krL4rYCXK3jsMYtiAIIFBJ2Y9hZ35yM4q9lQQhHCVx97fpQwpA
KrpHriPhfSNjdGCWx73DZose05e/ZuVQGlLaeXSEcam4Cd3xQ3fGVDN/92kqtPMG
1tpZPNaeS4Zt38wSoFsxLyH/O3Hlc1UKeP4sa0iXf66sDDbjHdI4CtJlW8FLbbAd
lOfF0IcOGlyjhaTKwahFIIxUVgfUtFugsb3pLXI9ll+AqX1OMic7pnRF+uLCmK3w
UkcOcRnv3n8nyKX4UhexSpVIuOwW4YiAzjXnfdDHOoZRWOte271PwSLUneb/urs/
28tV/NhUVDgnRoA8Mj/ZP4w4EP6TNV3DPbxMQt2XS9LfHpqUsHRBsCtgIaj4qazQ
LAZAbB1t0hmkUZXlFvNSwPL2364Bd5aMTZOPRkLNPiQBT27ffXPJmSbURLM0B6xK
cVhjE9ic9x/foF2FctuYka4zrJ5CLnSohuo9hSZ1+wqE8IQz5D0CggEBAO+f7w3j
SLpy0VqwueKSSRbLpSrwIfBav+j0kNrSJiR5uwbN0cwIoz0X6u6QjS9ZsaxjvOcN
0T7w5QOvUPbVKa1m0258IaFVk4wkNaGxM4uTI76WTSqXCqLP9j7LdnUJe7MwL4os
A1Ioik24imlNp7yRjkjH0jXUP7ymAzU5iKaugoyh6FMieLnve2Ix0N2k+fDF3J62
mxlV4oBHiISdyYgvkSogaUGpKu680D3QyawaxsM8mHnP54s1DbqrhiQzVV0tiBWL
IM3y6LgSl+43lQ/cxEEkAnGorS4iCFWaq3VbhUjycC50sTSIQp5MpCB7kfLwbe9g
YpMwj2YPlogm0YMCggEBAMv0cahkaIPokrNGQP40oXukPlbDdnX1U90EEml34vWV
Y1jkiMfaHBWxwECIZUjzeIT5u2ji4/yGddWa+qY8ppgrvYMsISxHvGunk3xZ7fl2
ys472cCon8q2FGZ/+l6oqBr06QKX+D0IQaotmSJRtkGr7P00OzK5gmtIxLQKbhEb
NQ0ofoKDH/EqVEZIJti3ctS1ilvU18G0UMM4FiKWc5VW9jdVNlF15KnYJNeo2GXv
AZTMS8yVbI8G/r9NAo25fK0JB35j/wE0uXbgJ+iOkwx8GUWcRxfbOjl9hzZtKvZ7
U+sa0EJ9jyMhFSeeXPz3oCrt1rbXBwxQtgVe+iZYKRcCggEAH8yQk746s4tzHt7e
/CM/kcfallUhm9zfJNH3uyIyL5r7584+bh4jU4MuCRSjt8nmWyMtOVhLEVg0fAWy
796f1kQUANB2QguyNeHEQD3cwkP3dV5KxUEgBzUjz3d+s89bXA8j7+khU7DPkbrQ
m2LTxKFoSV5DFiOhha5eNJz69muoJXOC+i1T6hDOxdwohJFVHc+UFHfVI0qTcUSM
6FRsHyd40ydT8IO7j8z8sYdYi/9NqzEKZvfhGUckGEaU2Y76YBAfxAQfiVUX7v2A
rfswS9eXL7HQpTamLL4Vbw7EfCF2EZUir/eKYJdIh+tRyIG9f4jKff7Ddhb2oKum
5VCJcwKCAQBiGfLtf1ZyVFTz3E/4thISab7+dsgtFtK+1W2Rw3Oskq2VnV9ZWcT2
fmgt4i1tuIZ417JYUgI9feOB2ijD+xpayXc/d+OA7ARqd9FOF+eKfaQxLMKhk7pA
g/IuF1KzY0ZwqOrHL5fcq3MCSyqEQm97CRpV9GChFm/v8LGEtBubKM4MxTSMzEt5
8dVVdPESfrLCM4wYfblF19ic/gZPnrR72bdWiCs3ZZCWTXvzK6ji5uKI0veGsTzl
UwUHuSAIUXbxuA0dszV+PAEVd95aUvHSKILzY6cih3VrH8EA4eOvaUTFKkGQKdrG
l+wYAWlS2Dz3SS1lBurB9rSGwtdpyDADAoIBAGMC5nj3Ij9GkKcnPCuc80Jz1Z6E
YN5w2QaSxT8Wsvnw8CM2QQ8fVp1o/5bbN2agsJ0m9444lN0WWEbKA2reYBtvLWx6
h9ueo+xhss9KycZ3inx9skZpdveUQBukF2YE2/kAT1OjeDqYal+u1P6jiJ4TLten
Boso97KU/oaSR5e/24vgri5JvdL/mdC2sLOEvQ5HhB85zQ02tHqlzw9miFsB0Ikx
FJh9NjrLxFrkw91gpLe/axrkH9sJybgfyWegf5u/Jr2ZsRjCemDovpXhyJxwNdJj
//08AtebNx8XKuUOUtk2mOR2abcHP93lccOnBhS4etAcaM/Al6hb2wuJDoA=
-----END RSA PRIVATE KEY-----
'
$env:TARGET='10.0.0.10'
$env:MODULEPATH='../'
$env:INSTALLER_TARBALL='C:\temp\puppet-enterprise-2018.1.4-el-7-x86_64.tar.gz'

bolt plan run puppet_server_deployer::deploy --user root --password vagrant --run_as root -n $env:TARGET --no-host-key-check --modulepath $env:MODULEPATH installer_tarball="$($env:INSTALLER_TARBALL)" pe_conf_content="$($env:PE_CONF_CONTENT)" r10k_key_content="$($env:R10K_KEY_CONTENT)"

*/

plan puppet_server_deployer::deploy(
  String[1] $installer_tarball,
  String[1] $installer_tarball_remote   ='/tmp/installer.tar.gz',
  Optional[String[1]] $pe_conf_content  = @(EOS)
  {    "console_admin_password": "puppet",    "puppet_enterprise::puppet_master_host": "%{::trusted.certname}"  }
  | EOS
  ,
  String[1] $pe_conf_remote             ='/tmp/pe.conf',
  Optional[String[1]] $r10k_key_content = undef ,
  String[1] $r10k_key_remote            ='/etc/puppetlabs/r10k/id-control_repo.rsa',
  TargetSpec $nodes
){
  # Upload installer tarball
  upload_file($installer_tarball, $installer_tarball_remote, $nodes)#'_run_as' => 'root')

  # Prep pe.conf for PE install (apply puppet, then remove agent)
  $nodes.apply_prep
  apply($nodes) {
    file { $pe_conf_remote:
      ensure  => 'file',
      content => $pe_conf_content,
      mode    => '0400',
    }
    file { ['/etc/puppetlabs','/etc/puppetlabs/r10k']:
        ensure => 'directory',
    }
  }
  run_command("yum remove puppet -y", $nodes, '_catch_errors' => true,'_run_as' => 'root' )

  # Clean workspace, for tarball extract
  run_command('rm -rf /tmp/puppetserver ; mkdir -p /tmp/puppetserver', $nodes, '_catch_errors' => true,'_run_as' => 'root' ) #
  run_command("tar -zxvf ${installer_tarball_remote} -C /tmp/puppetserver --strip-components=1", $nodes, '_catch_errors' => true,'_run_as' => 'root' )

  # Install PE
  run_command("/tmp/puppetserver/puppet-enterprise-installer -c \"${pe_conf_remote}\"", $nodes, '_catch_errors' => true,'_run_as' => 'root' )

  # Configure r10k key for code manager
  apply($nodes) {
    file { $r10k_key_remote:
      ensure  => 'file',
      content => $r10k_key_content,
      mode    => '0400',
      owner   => 'pe-puppet'
    }
  }

  # Complete puppet install & check service status
  $puppet_agent_cmd = '/opt/puppetlabs/puppet/bin/puppet agent -t'
  $puppet_agent_wait_command = "while [ -f /opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock ] ; do sleep 5 ; echo \"\$(date) /opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock exists - waiting for puppet agent to finish...\"  ; done"
  $run_puppet = "${puppet_agent_wait_command} ; ${puppet_agent_cmd}"
  run_command("${run_puppet} ; ${run_puppet} ; ${run_puppet}", $nodes, '_catch_errors' => true,'_run_as' => 'root' )
  return run_command("/opt/puppetlabs/puppet/bin/puppet infra status | grep \'10 of 11 services are fully operational.\'", $nodes, '_catch_errors' => true,'_run_as' => 'root' )

}
