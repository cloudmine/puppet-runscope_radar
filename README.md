# puppet-runscope_radar

#### Table of Contents

1. [Overview](#overview)
2. [Requirements - OSes and Puppet modules](#requirements)
3. [Usage - Quickly getting started](#usage)
4. [Configuration - Required and optional configuration options](#configuration)
5. [Development - Guide for contributing to the module](#development)
6. [Maintainers - Who helps keep this module up to date](#maintainers)
7. [Release Notes / Changelog](CHANGELOG.md)

## Overview

Puppet module for [Runscope Radar Agent](https://www.runscope.com/docs/api-testing/agent).

## Requirements

### Operation Systems

These are the operating systems for which the module has been tested.

* Ubuntu 14.04

### Puppet Modules

* [puppet/archive](https://forge.puppetlabs.com/puppet/archive)
* [puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib)

## Usage

If you do not already have an application token, team ID, and agent ID for the Runscope Radar Agent, generate/gather these by manually downloading, unzipping, and running the command without arguments the first time.

### Using Hiera

Add required configuration hiera in the appropriate location for your environment, e.g.

```
runscope_radar::agent_id: my-runscope-agent-id
runscope_radar::team_id: my-runscope-team-id
runscope_radar::token: my-runscope-app-token
```

Then add `include runscope_radar` in your `site.pp` or add `runscope_radar` to your classes hiera.

### Directly without Hiera

```
class { 'runscope_radar':
  agent_id => 'my-runscope-agent-id',
  team_id  => 'my-runscope-team-id',
  token    => 'my-runscope-app-token',
}
```

## Configuration

### Required Configuration

Parameter | Description | Type | Default
-----|-------------|------|--------
agent_id | Runscope Radar Agent ID | String | undef
team_id | Runscope Team ID | String | undef
token | Runscope application token | String | undef

### Optional Configuration

Parameter | Description | Type | Default
-----|-------------|------|--------
agent_name | Agent name | String | `$::fqdn`
api_host | Runscope API hostname | String | https://api.runscope.com
cafile | Agent HTTPS Certificate Authority file | String | undef
config_dir | Configuration directory | String | (auto-detected, see params.pp)
disconnect_timeout | Agent disconnect timeout in seconds | Fixnum | 5
group | Group for running agent | String | runscope
group_manage | Whether to manage agent group creation | Boolean | true
install_binary | Installation binary filename | String | (auto-detected, see params.pp)
install_dir | Installation directory | String | (auto-detected, see params.pp)
service_enable | Enable agent service on boot | Boolean | true
service_ensure | Ensure agent service running | Boolean | true
service_manage | Whether to manage agent service | Boolean | true
service_style | OS service style | String | (auto-detected, see params.pp)
threads | Agent threads | Fixnum | 10
timeout | Agent timeout in seconds | Fixnum | 20
url | Full URL to agent zip file | String | (auto-detected, see params.pp)
user | User for running agent | String | runscope
user_manage | Whether to manage agent user creation | Boolean | true

## Development

* Full development and testing workflow with rspec-puppet, puppet-lint, and friends: [TESTING.md](TESTING.md)

### To use aws instead of virtualbox vagrant hosts
* vagrant plugin install vagrant-aws
* vagrant plugin install puppet
* vagrant plugin install nugrant (https://github.com/maoueh/nugrant)
* sudo gem install puppet
* Debug comands by setting VAGRANT_LOG to the appropriate level
```
VAGRANT_LOG=debug vagrant $command (to debug)
```
* create ~/.vagrantuser
```
aws:
  access_key: "YOUR_KEY"
  secret_key: "YOUR_SECRET"
  keypair_name: "$USERNAME"
  ssh_username: "$USERNAME"
  ssh_pubkey: "FULL_PATH_TO_PEM"
```
* vagrant up --provider aws dummy
* vagrant ssh
* vagrant halt | suspend | destroy

## Maintainers

* CloudMine Engineering
