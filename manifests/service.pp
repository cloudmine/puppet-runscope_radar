# == Class: runscope_radar::service
#
# This class handles running the Runscope Radar Agent as a service.
#
# === Copyright:
#
# Copyright (c) 2016 CloudMine, Inc. http://cloudmineinc.com/
# See project LICENSE file for full information.
#
class runscope_radar::service inherits runscope_radar {
  if $runscope_radar::service_manage {
    service { 'runscope-radar':
      ensure => $runscope_radar::service_ensure,
      enable => $runscope_radar::service_enable,
    }
  }
}
