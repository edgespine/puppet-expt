# Puppet master of masters (MoM)
class role::puppet_master_of_masters {
  include profile::linux::base
  include profile::puppet_server::puppet_agent
  include profile::puppet_server::backup
}
