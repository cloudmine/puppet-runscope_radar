# == Class: runscope_radar::config
#
# This class handles configuring the Runscope Radar Agent and service
# if applicable.
#
# === Copyright:
#
# Copyright (c) 2016 CloudMine, Inc. http://cloudmineinc.com/
# See project LICENSE file for full information.
#
class runscope_radar::config inherits runscope_radar {
  # Avoid duplicate File declaration on Windows from install_dir
  if $::operatingsystem != 'Windows' {
    file { $runscope_radar::config_dir:
      ensure => directory,
    }
  }

  file { "${runscope_radar::config_dir}/radar.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('runscope_radar/radar.conf.erb'),
  }

  if $runscope_radar::service_manage {
    case $runscope_radar::service_style {
      # 'debian': {
      #   file { '/etc/init.d/runscope-radar':
      #     ensure  => file,
      #     owner   => 'root',
      #     group   => 'root',
      #     mode    => '0755',
      #     content => template('runscope_radar/runscope-radar.debian.erb'),
      #   }
      # }
      'launchd' : {
        file { '/Library/LaunchDaemons/com.runscope.radar.plist':
          ensure  => file,
          owner   => 'root',
          group   => 'wheel',
          mode    => '0644',
          content => template('runscope_radar/runscope-radar.launchd.erb'),
        }
      }
      'scm': {
        exec { 'sc-create-runscope-radar':
          command => "c:/windows/system32/sc.exe create runscope-radar start= auto binpath= \"${runscope_radar::install_dir}/${runscope_radar::install_binary}\" displayname= \"Runscope Radar Agent\"",
          unless  => 'c:/windows/system32/sc.exe test runscope-radar',
        }
      }
      'systemd': {
        file { '/lib/systemd/system/runscope-radar.service':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => template('runscope_radar/runscope-radar.systemd.erb'),
        } ~>
        exec { 'runscope-radar-systemd-reload':
          command     => 'systemctl daemon-reload',
          path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
          refreshonly => true,
        }
      }
      # 'sysv': {
      #   file { '/etc/init.d/runscope-radar':
      #     ensure  => file,
      #     owner   => 'root',
      #     group   => 'root',
      #     mode    => '0755',
      #     content => template('runscope_radar/runscope-radar.sysv.erb'),
      #   }
      # }
      'upstart': {
        file { '/etc/init/runscope-radar.conf':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => template('runscope_radar/runscope-radar.upstart.erb'),
        }
        file { '/etc/init.d/runscope-radar':
          ensure => link,
          target => '/lib/init/upstart-job',
          owner  => 'root',
          group  => 'root',
          mode   => '0755',
        }
      }
      default: {
        fail("runscope_radar: Unimplemented service configuration: ${runscope_radar::service_style}")
      }
    }
  }
}
