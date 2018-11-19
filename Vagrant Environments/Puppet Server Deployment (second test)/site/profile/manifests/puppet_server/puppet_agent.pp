# Control the puppet agent version and disable the repo
class profile::puppet_server::puppet_agent {
  package { 'puppet-agent':
    ensure => '5.5.8',
  }

  yumrepo { 'puppet':
    ensure   => 'present',
    baseurl  => 'http://yum.puppetlabs.com/puppet/el/7/$basearch',
    descr    => 'Puppet Repository el 7 - $basearch',
    enabled  => '0',
    gpgcheck => '1',
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-release',
  }
}
