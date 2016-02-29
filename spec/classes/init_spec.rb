require 'spec_helper'

describe 'runscope_radar' do
  RSpec.configure do |c|
    c.default_facts = {
      :architecture           => 'amd64',
      :kernel                 => 'Linux',
      :operatingsystem        => 'Ubuntu',
      :operatingsystemrelease => '14.04',
      :osfamily               => 'Debian',
      :puppetversion          => '4.3.2',
    }
  end

  context 'When defaults' do
    it { should_not compile() }
  end

  context 'When defaults and required parameters provided on any OS' do
    let(:params) {{
      :agent_id => 'abcd-efgh-ijklmnop',
      :team_id  => 'abcd-efgh-ijklmnop',
      :token    => 'abcd-efgh-ijklmnop',
    }}
    it { should contain_class('archive') }
    it { should contain_class('runscope_radar') }
    it { should contain_class('runscope_radar::install') }
    it { should contain_class('runscope_radar::config') }
    it { should contain_class('runscope_radar::service') }

    it { should contain_group('runscope') }
    it { should contain_user('runscope') }
  end

  context 'When defaults and required parameters provided on CentOS 6.0' do
    let(:facts) {{
      :kernel                 => 'Linux',
      :operatingsystem        => 'CentOS',
      :operatingsystemrelease => '6.0',
      :osfamily               => 'RedHat',
    }}
    let(:params) {{
      :agent_id => 'abcd-efgh-ijklmnop',
      :team_id  => 'abcd-efgh-ijklmnop',
      :token    => 'abcd-efgh-ijklmnop',
    }}

    it { should_not compile() }
    it { should raise_error(Puppet::Error, /runscope_radar: Unimplemented service configuration/) }
  end

  context 'When defaults and required parameters provided on CentOS 7.0' do
    let(:facts) {{
      :kernel                 => 'Linux',
      :operatingsystem        => 'CentOS',
      :operatingsystemrelease => '7.0',
      :osfamily               => 'RedHat',
    }}
    let(:params) {{
      :agent_id => 'abcd-efgh-ijklmnop',
      :team_id  => 'abcd-efgh-ijklmnop',
      :token    => 'abcd-efgh-ijklmnop',
    }}

    it { should contain_file('/lib/systemd/system/runscope-radar.service').with({
      'ensure'  => 'file',
    }).with_content(/^ExecStart=\/opt\/runscope\/runscope-radar -f \/etc\/runscope\/radar\.conf/) }
  end

  context 'When defaults and required parameters provided on Darwin' do
    let(:facts) {{
      :kernel                 => 'Darwin',
      :operatingsystem        => 'Darwin',
      :operatingsystemrelease => '15.3.0',
      :osfamily               => 'Darwin',
    }}
    let(:params) {{
      :agent_id => 'abcd-efgh-ijklmnop',
      :team_id  => 'abcd-efgh-ijklmnop',
      :token    => 'abcd-efgh-ijklmnop',
    }}
    
    it { should contain_file('/usr/local/opt/runscope').with({
      'ensure' => 'directory'
    }) }

    it { should contain_file('/Library/LaunchDaemons/com.runscope.radar.plist').with({
      'ensure'  => 'file',
    }).with_content(/\<string\>\/usr\/local\/opt\/runscope\/runscope-radar\<\/string\>/) }

    it { should contain_file('/usr/local/etc/runscope').with({
      'ensure' => 'directory'
    }) }
    it { should contain_file('/usr/local/etc/runscope/radar.conf').with({
      'ensure' => 'file',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
    }).with_content(/^name=\w+/) }

    it { should contain_service('runscope-radar').with({
      'ensure' => 'running',
      'enable' => 'true',
    }) }
  end

  context 'When defaults and required parameters provided on Debian 7' do
    let(:facts) {{
      :kernel                 => 'Linux',
      :operatingsystem        => 'Debian',
      :operatingsystemrelease => '7.0',
      :osfamily               => 'Debian',
    }}
    let(:params) {{
      :agent_id => 'abcd-efgh-ijklmnop',
      :team_id  => 'abcd-efgh-ijklmnop',
      :token    => 'abcd-efgh-ijklmnop',
    }}

    it { should_not compile() }
    it { should raise_error(Puppet::Error, /runscope_radar: Unimplemented service configuration/) }
  end

  context 'When defaults and required parameters provided on Debian 8' do
    let(:facts) {{
      :kernel                 => 'Linux',
      :operatingsystem        => 'Debian',
      :operatingsystemrelease => '8.0',
      :osfamily               => 'Debian',
    }}
    let(:params) {{
      :agent_id => 'abcd-efgh-ijklmnop',
      :team_id  => 'abcd-efgh-ijklmnop',
      :token    => 'abcd-efgh-ijklmnop',
    }}

    it { should contain_file('/lib/systemd/system/runscope-radar.service').with({
      'ensure'  => 'file',
    }).with_content(/^ExecStart=\/opt\/runscope\/runscope-radar -f \/etc\/runscope\/radar\.conf/) }
end

  context 'When defaults and required parameters provided on Linux' do
    let(:params) {{
      :agent_id => 'abcd-efgh-ijklmnop',
      :team_id  => 'abcd-efgh-ijklmnop',
      :token    => 'abcd-efgh-ijklmnop',
    }}
    
    it { should contain_file('/opt/runscope').with({
      'ensure' => 'directory'
    }) }

    it { should contain_file('/etc/runscope').with({
      'ensure' => 'directory'
    }) }
    it { should contain_file('/etc/runscope/radar.conf').with({
      'ensure' => 'file',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
    }).with_content(/^name=\w+/) }

    it { should contain_service('runscope-radar').with({
      'ensure' => 'running',
      'enable' => 'true',
    }) }
  end

  context 'When defaults and required parameters provided on Ubuntu 14.04' do
    let(:params) {{
      :agent_id => 'abcd-efgh-ijklmnop',
      :team_id  => 'abcd-efgh-ijklmnop',
      :token    => 'abcd-efgh-ijklmnop',
    }}

    it { should contain_file('/etc/init/runscope-radar.conf').with({
      'ensure'  => 'file',
    }).with_content(/^exec \/opt\/runscope\/runscope-radar -f \/etc\/runscope\/radar\.conf/) }
  end

  context 'When defaults and required parameters provided on Ubuntu 16.04' do
    let(:facts) {{
      :operatingsystemrelease => '16.04',
    }}
    let(:params) {{
      :agent_id => 'abcd-efgh-ijklmnop',
      :team_id  => 'abcd-efgh-ijklmnop',
      :token    => 'abcd-efgh-ijklmnop',
    }}

    it { should contain_file('/lib/systemd/system/runscope-radar.service').with({
      'ensure'  => 'file',
    }).with_content(/^ExecStart=\/opt\/runscope\/runscope-radar -f \/etc\/runscope\/radar\.conf/) }
  end

  context 'When defaults and required parameters provided on Windows' do
    let(:facts) {{
      :kernel                 => 'Windows',
      :operatingsystem        => 'Windows',
      :operatingsystemrelease => 'Server 2012',
      :osfamily               => 'Windows',
    }}
    let(:params) {{
      :agent_id => 'abcd-efgh-ijklmnop',
      :team_id  => 'abcd-efgh-ijklmnop',
      :token    => 'abcd-efgh-ijklmnop',
    }}
    
    it { should contain_file('c:/Program Files/Runscope').with({
      'ensure' => 'directory'
    }) }

    it { should contain_file('c:/Program Files/Runscope/radar.conf').with({
      'ensure' => 'file',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
    }).with_content(/^name=\w+/) }

    it { should contain_service('runscope-radar').with({
      'ensure' => 'running',
      'enable' => 'true',
    }) }
  end

  context 'When missing agent_id' do
    let(:params) {{
      :team_id  => 'abcd-efgh-ijklmnop',
      :token    => 'abcd-efgh-ijklmnop',
    }}
    it { should_not compile() }
    it { should raise_error(Puppet::Error, /runscope_radar: Please provide Runscope agent ID/) }
  end

   context 'When missing team_id' do
    let(:params) {{
      :agent_id => 'abcd-efgh-ijklmnop',
      :token    => 'abcd-efgh-ijklmnop',
    }}
    it { should_not compile() }
    it { should raise_error(Puppet::Error, /runscope_radar: Please provide Runscope team ID/) }
  end

   context 'When missing token' do
    let(:params) {{
      :agent_id => 'abcd-efgh-ijklmnop',
      :team_id  => 'abcd-efgh-ijklmnop',
    }}
    it { should_not compile() }
    it { should raise_error(Puppet::Error, /runscope_radar: Please provide Runscope application token/) }
  end

  context 'When not managing group' do
    let(:params) {{
      :agent_id     => 'abcd-efgh-ijklmnop',
      :group_manage => false,
      :team_id      => 'abcd-efgh-ijklmnop',
      :token        => 'abcd-efgh-ijklmnop',
    }}
    it { should_not contain_group('runscope') }
  end

  context 'When not managing service' do
    let(:params) {{
      :agent_id       => 'abcd-efgh-ijklmnop',
      :service_manage => false,
      :team_id        => 'abcd-efgh-ijklmnop',
      :token          => 'abcd-efgh-ijklmnop',
    }}
    it { should_not contain_file('/etc/init/runscope-radar.conf') }
    it { should_not contain_service('runscope-radar') }
  end

  context 'When not managing user' do
    let(:params) {{
      :agent_id    => 'abcd-efgh-ijklmnop',
      :team_id     => 'abcd-efgh-ijklmnop',
      :token       => 'abcd-efgh-ijklmnop',
      :user_manage => false,
    }}
    it { should_not contain_user('runscope') }
  end

  context 'When service disabled' do
    let(:params) {{
      :agent_id       => 'abcd-efgh-ijklmnop',
      :service_enable => false,
      :team_id        => 'abcd-efgh-ijklmnop',
      :token          => 'abcd-efgh-ijklmnop',
    }}
    it { should contain_service('runscope-radar').with({
      'enable' => 'false',
    }) }
  end

  context 'When service stopped' do
    let(:params) {{
      :agent_id       => 'abcd-efgh-ijklmnop',
      :service_ensure => 'stopped',
      :team_id        => 'abcd-efgh-ijklmnop',
      :token          => 'abcd-efgh-ijklmnop',
    }}
    it { should contain_service('runscope-radar').with({
      'ensure' => 'stopped',
    }) }
  end

  context 'When unsupported architecture' do
    let(:facts) {{ :architecture => 'bogus' }}
    it { should_not compile() }
    it { should raise_error(Puppet::Error, /runscope_radar: Unimplemented kernel architecture/) }
  end

  context 'When unsupported service style' do
    let(:params) {{
      :agent_id      => 'abcd-efgh-ijklmnop',
      :service_style => 'foobar',
      :team_id       => 'abcd-efgh-ijklmnop',
      :token         => 'abcd-efgh-ijklmnop',
    }}
    it { should_not compile() }
    it { should raise_error(Puppet::Error, /runscope_radar: Unimplemented service configuration/) }
  end
end
