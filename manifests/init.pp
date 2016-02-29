# == Class: runscope_radar
#
# This class handles coordinating the installation, configuration, and runtime
# of the Runscope Radar Agent.
#
# === Copyright:
#
# Copyright (c) 2016 CloudMine, Inc. http://cloudmineinc.com/
# See project LICENSE file for full information.
#
class runscope_radar (
  $agent_id           = undef,
  $agent_name         = $::fqdn,
  $api_host           = 'https://api.runscope.com',
  $cafile             = undef,
  $config_dir         = $runscope_radar::params::config_dir,
  $disconnect_timeout = 5,
  $ensure             = present,
  $group              = 'runscope',
  $group_manage       = true,
  $install_binary     = $runscope_radar::params::install_binary,
  $install_dir        = $runscope_radar::params::install_dir,
  $service_enable     = true,
  $service_ensure     = running,
  $service_manage     = true,
  $service_style      = $runscope_radar::params::service_style,
  $team_id            = undef,
  $threads            = 10,
  $timeout            = 20,
  $token              = undef,
  $url                = $runscope_radar::params::url,
  $user               = 'runscope',
  $user_manage        = true,
) inherits runscope_radar::params {
  if $agent_id == undef or $agent_id == '' {
    fail('runscope_radar: Please provide Runscope agent ID')
  }

  if $team_id == undef or $team_id == '' {
    fail('runscope_radar: Please provide Runscope team ID')
  }

  if $token == undef or $token == '' {
    fail('runscope_radar: Please provide Runscope application token')
  }

  anchor { 'runscope_radar::begin': } ->
  class { '::runscope_radar::install': } ->
  class { '::runscope_radar::config': } ->
  class { '::runscope_radar::service': }
  anchor { 'runscope_radar::end': }
}
