# Linux webserver role
class role::linux_webserver {
  include profile::linux::base
  include profile::linux::apache
  include profile::linux::php
  # include profile::linux::lwf_mounts
}
