# == Class: runscope_radar::install
#
# This class handles fetching and installing the Runscope Radar Agent.
#
# === Copyright:
#
# Copyright (c) 2016 CloudMine, Inc. http://cloudmineinc.com/
# See project LICENSE file for full information.
#
class runscope_radar::install inherits runscope_radar {
  include ::archive

  file { $runscope_radar::install_dir:
    ensure => directory,
  } ->

  archive { "${runscope_radar::install_dir}/runscope-radar.zip":
    ensure       => $runscope_radar::ensure,
    creates      => "${runscope_radar::install_dir}/${runscope_radar::install_binary}",
    extract      => true,
    extract_path => $runscope_radar::install_dir,
    source       => $runscope_radar::url,
  }

  if $runscope_radar::user_manage {
    user { $runscope_radar::user:
      ensure => present,
      system => true,
    }

    if $runscope_radar::group_manage {
      Group[$runscope_radar::group] -> User[$runscope_radar::user]
    }
  }
  if $runscope_radar::group_manage {
    group { $runscope_radar::group:
      ensure => present,
      system => true,
    }
  }
}
