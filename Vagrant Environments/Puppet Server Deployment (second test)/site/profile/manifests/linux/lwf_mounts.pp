# Class to mount linux web farm data directories using autofs
class profile::linux::lwf_mounts {
        file { ['/data/','/data/www/','/data/www/external']:
                ensure => 'directory',
        }

        class { 'autofs':
                package_ensure => present,
                service_enable => true,
                service_ensure => 'running',
        }

        autofs::mount { '/data/www/external':
                mount       => '/data/www/external',
                mapfile     => '/etc/auto.nfs',
        }

        autofs::mapfile { '/etc/auto.nfs':
                path => '/etc/auto.nfs',
                mappings => [
                        {'key' => 'chnmr', options => '-ro,vers=3,rsize=32768', 'fs' => 'icnfs3.cc.ic.ac.uk:/san/CH-NMR'},
                        {'key' => 'sharedlog', options => '-ro,vers=3', 'fs' => 'iclwf-sharedlog.cc.ic.ac.uk:/san/iclwf/sharedlog'},
                ],
        }
}
