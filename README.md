# yum

#### Table of Contents

1. [Description](#description)
2. [New to bolt?](#new-to-bolt)
    * [Newcomers quickstart](#newcomers-quickstart)
3. [Gotchas/Limitations](#gotchas)
4. [Usage - Examples and general tips on how to use the content in this module](#usage)
5. [# Contributions - Guide for contributing to the module](#contributions)

# Description

These tasks help interact with yum at various levels via Puppet Bolt or Puppet Enterprise tasks. 


# New to bolt?

Check these out:

[Installing Bolt](https://puppet.com/docs/bolt/latest/bolt_installing.html)

[Running Bolt commands](https://puppet.com/docs/bolt/latest/running_bolt_commands.html)

[Inventory File Examples](https://puppet.com/docs/bolt/latest/inventory_file_v2.html#inventory-file-examples)

[Bolt Command reference](https://puppet.com/docs/bolt/latest/bolt_command_reference.html)


# Newcomers quickstart

Create a Bolt project + Boltdir > Create Puppetfile + Add this module > Install module > Run tasks! :)

``` shell
mkdir -p bolt/Boltdir/
cd bolt/Boltdir/

cat << EOF >> Puppetfile
# Modules from the Puppet Forge.
mod 'kinners00-yum', 	    '0.4.6'
EOF

bolt puppetfile install
```

# Gotchas

1. **You must pass 'run as root' param in order for tasks to successfully complete.** You can do this by specifying ```--run-as root``` on your bolt command or by adding ```run-as: root``` to your config in your inventory.yaml file. 

2. `yum::security`, `yum::cve` and `yum::advisory` tasks will only work if you have the relevant security metadata repos enabled. To the best of my knowledge, this effectively limits this task to RHEL and OEL boxes. It will *look* like it works on centos etc (i.e. executes successfully) but it will never "find" any security updates if the corresponding repo isn't there.

# Usage

## Show all available yum tasks

Will show all tasks that match the module name `yum`.  

``` shell
bolt task show --filter yum
```

## Show task info/metadata

This will show a brief description of the tasks function as well the parameters that the task can consume.

``` shell
bolt task show yum::security
```
## Running a task

Pass in the relevant parameters and run the task.

``` shell
bolt task run --targets rhelboxes yum::security security=minimal
```
## Plan example

**If you a bolt aficionado, you can ignore this section.**

I've included a sample plan to demonstrate how you can chain together tasks to achieve an overall workflow. In this plan we are running the cache task followed by the security task. Plans can be made up of tasks from other modules too. 

``` puppet
plan yum::security_cache(
  TargetSpec $targets,
  String $cache,
  String $security
) {

  # Cache and security update 
  run_task('yum::update_cache', $targets, cache => $cache)
  run_task('yum::security', $targets, security => $security)

  }
```
## Running a plan

Add `--verbose` to the end of your bolt command to get output from each task in the plan.

``` shell
bolt plan run yum::security_cache targets=rhelboxes cache=update security=minimal
```

# Contributions

This module contains a simple set of tasks (written in bash). The logic on some tasks could be smarter/cleaner but they should all work. I will get round to improving them at some point in the near future.  

If anyone would like to contribute to the module, that would be awesome and very much welcomed.

If you're experiencing any bugs, please raise an issue below:

Repo:        https://github.com/kinners00/yum/issues

Issues link: https://github.com/kinners00/yum/issues