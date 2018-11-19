# Compile master role
class role::puppet_compile_master {
  include profile::linux::base
  include profile::puppet_server::puppet_agent
}
