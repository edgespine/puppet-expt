# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile::linux::php
class profile::linux::php (
$php_version          =  lookup('profile::linux::php::php_version'),
$php_packages         = [ 
  'php-cli',
  'php-pear',
  'php-pdo',
  'php-mysqlnd',
  'php-gd',
  'php-mbstring',
  'php-mcrypt',
  'php-xml',
  'php-opcache'
],
$epel_gpg_key         = '/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7',
$epel_gpg_key_content = @(EOC)
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.11 (GNU/Linux)

mQINBFKuaIQBEAC1UphXwMqCAarPUH/ZsOFslabeTVO2pDk5YnO96f+rgZB7xArB
OSeQk7B90iqSJ85/c72OAn4OXYvT63gfCeXpJs5M7emXkPsNQWWSju99lW+AqSNm
jYWhmRlLRGl0OO7gIwj776dIXvcMNFlzSPj00N2xAqjMbjlnV2n2abAE5gq6VpqP
vFXVyfrVa/ualogDVmf6h2t4Rdpifq8qTHsHFU3xpCz+T6/dGWKGQ42ZQfTaLnDM
jToAsmY0AyevkIbX6iZVtzGvanYpPcWW4X0RDPcpqfFNZk643xI4lsZ+Y2Er9Yu5
S/8x0ly+tmmIokaE0wwbdUu740YTZjCesroYWiRg5zuQ2xfKxJoV5E+Eh+tYwGDJ
n6HfWhRgnudRRwvuJ45ztYVtKulKw8QQpd2STWrcQQDJaRWmnMooX/PATTjCBExB
9dkz38Druvk7IkHMtsIqlkAOQMdsX1d3Tov6BE2XDjIG0zFxLduJGbVwc/6rIc95
T055j36Ez0HrjxdpTGOOHxRqMK5m9flFbaxxtDnS7w77WqzW7HjFrD0VeTx2vnjj
GqchHEQpfDpFOzb8LTFhgYidyRNUflQY35WLOzLNV+pV3eQ3Jg11UFwelSNLqfQf
uFRGc+zcwkNjHh5yPvm9odR1BIfqJ6sKGPGbtPNXo7ERMRypWyRz0zi0twARAQAB
tChGZWRvcmEgRVBFTCAoNykgPGVwZWxAZmVkb3JhcHJvamVjdC5vcmc+iQI4BBMB
AgAiBQJSrmiEAhsPBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBqL66iNSxk
5cfGD/4spqpsTjtDM7qpytKLHKruZtvuWiqt5RfvT9ww9GUUFMZ4ZZGX4nUXg49q
ixDLayWR8ddG/s5kyOi3C0uX/6inzaYyRg+Bh70brqKUK14F1BrrPi29eaKfG+Gu
MFtXdBG2a7OtPmw3yuKmq9Epv6B0mP6E5KSdvSRSqJWtGcA6wRS/wDzXJENHp5re
9Ism3CYydpy0GLRA5wo4fPB5uLdUhLEUDvh2KK//fMjja3o0L+SNz8N0aDZyn5Ax
CU9RB3EHcTecFgoy5umRj99BZrebR1NO+4gBrivIfdvD4fJNfNBHXwhSH9ACGCNv
HnXVjHQF9iHWApKkRIeh8Fr2n5dtfJEF7SEX8GbX7FbsWo29kXMrVgNqHNyDnfAB
VoPubgQdtJZJkVZAkaHrMu8AytwT62Q4eNqmJI1aWbZQNI5jWYqc6RKuCK6/F99q
thFT9gJO17+yRuL6Uv2/vgzVR1RGdwVLKwlUjGPAjYflpCQwWMAASxiv9uPyYPHc
ErSrbRG0wjIfAR3vus1OSOx3xZHZpXFfmQTsDP7zVROLzV98R3JwFAxJ4/xqeON4
vCPFU6OsT3lWQ8w7il5ohY95wmujfr6lk89kEzJdOTzcn7DBbUru33CQMGKZ3Evt
RjsC7FDbL017qxS+ZVA/HGkyfiu4cpgV8VUnbql5eAZ+1Ll6Dw==
=hdPa
-----END PGP PUBLIC KEY BLOCK-----
| EOC
,
$remi_gpg_key         = '/etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
$remi_gpg_key_content = @(EOC)
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.7 (GNU/Linux)

mQGiBEJny1wRBACRnbQgZ6qLmJSuGvi/EwrRL6aW610BbdpLQRL3dnwy5wI5t9T3
/JEiEJ7GTvAwfiisEHifMfk2sRlWRf2EDQFttHyrrYXfY5L6UAF2IxixK5FL7PWA
/2a7tkw1IbCbt4IGG0aZJ6/xgQejrOLi4ewniqWuXCc+tLuWBZrGpE2QfwCggZ+L
0e6KPTHMP97T4xV81e3Ba5MD/3NwOQh0pVvZlW66Em8IJnBgM+eQh7pl4xq7nVOh
dEMJwVU0wDRKkXqQVghOxALOSAMapj5mDppEDzGLZHZNSRcvGEs2iPwo9vmY+Qhp
AyEBzE4blNR8pwPtAwL0W3cBKUx7ZhqmHr2FbNGYNO/hP4tO2ochCn5CxSwAfN1B
Qs5pBACOkTZMNC7CLsSUT5P4+64t04x/STlAFczEBcJBLF1T16oItDITJmAsPxbY
iee6JRfXmZKqmDP04fRdboWMcRjfDfCciSdIeGqP7vMcO25bDZB6x6++fOcmQpyD
1Fag3ZUq2yojgXWqVrgFHs/HB3QE7UQkykNp1fjQGbKK+5mWTrQkUmVtaSBDb2xs
ZXQgPFJQTVNARmFtaWxsZUNvbGxldC5jb20+iGAEExECACAFAkZ+MYoCGwMGCwkI
BwMCBBUCCAMEFgIDAQIeAQIXgAAKCRAATm9HAPl/Vv/UAJ9EL8ioMTsz/2EPbNuQ
MP5Xx/qPLACeK5rk2hb8VFubnEsbVxnxfxatGZ25AQ0EQmfLXRAEANwGvY+mIZzj
C1L5Nm2LbSGZNTN3NMbPFoqlMfmym8XFDXbdqjAHutGYEZH/PxRI6GC8YW5YK4E0
HoBAH0b0F97JQEkKquahCakj0P5mGuH6Q8gDOfi6pHimnsSAGf+D+6ZwAn8bHnAa
o+HVmEITYi6s+Csrs+saYUcjhu9zhyBfAAMFA/9Rmfj9/URdHfD1u0RXuvFCaeOw
CYfH2/nvkx+bAcSIcbVm+tShA66ybdZ/gNnkFQKyGD9O8unSXqiELGcP8pcHTHsv
JzdD1k8DhdFNhux/WPRwbo/es6QcpIPa2JPjBCzfOTn9GXVdT4pn5tLG2gHayudK
8Sj1OI2vqGLMQzhxw4hJBBgRAgAJBQJCZ8tdAhsMAAoJEABOb0cA+X9WcSAAn11i
gC5ns/82kSprzBOU0BNwUeXZAJ0cvNmY7rvbyiJydyLsSxh/la6HKw==
=6Rbg
-----END PGP PUBLIC KEY BLOCK-----
| EOC
,
){

  file { $remi_gpg_key:
    ensure  => 'file',
    content => $remi_gpg_key_content,
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
  }
  
  file { $epel_gpg_key:
    ensure  => 'file',
    content => $epel_gpg_key_content,
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
  }
  
  yumrepo { 'remi-php71':
    ensure     => 'present',
    require    => File[$remi_gpg_key],
    descr      => 'Remi\'s PHP 7.1 RPM repository for Enterprise Linux 7 - $basearch',
    enabled    => '1',
    gpgcheck   => '1',
    gpgkey     => "file://${remi_gpg_key}",
    mirrorlist => 'http://cdn.remirepo.net/enterprise/7/php71/mirror',

  }
  
  yumrepo { 'remi':
    ensure     => 'present',
    require    => File[$remi_gpg_key],
    descr      => 'Remi\'s RPM repository for Enterprise Linux 7 - $basearch',
    enabled    => '1',
    gpgcheck   => '1',
    gpgkey     => "file://${remi_gpg_key}",
    mirrorlist => 'http://cdn.remirepo.net/enterprise/7/remi/mirror',
  }
  
  yumrepo { 'epel':
    ensure         => 'present',
    require        => File[$epel_gpg_key],
    descr          => 'Extra Packages for Enterprise Linux 7 - $basearch',
    enabled        => '1',
    failovermethod => 'priority',
    gpgcheck       => '1',
    gpgkey         => "file://${epel_gpg_key}",
    metalink       => 'https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch',
  }
  
  package { 'php':
    ensure  => $php_version,
    require => Yumrepo['epel','remi','remi-php71'],
  }

  package { $php_packages:
    ensure  => installed,
    require => Yumrepo['epel','remi','remi-php71'],
  }
  
}
