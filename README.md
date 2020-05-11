# yum

These tasks help interact with yum at various levels via Puppet Bolt or Puppet Enterprise tasks.

# Gotchas

The security, cve and advisory tasks will only work if you have the relevant security metadata repos enabled. To the best of my knowledge, this effectively limits this task to RHEL and OEL boxes.

It will *look* like it works on centos etc (i.e. executes successfully) but it will never "find" any security updates if the corresponding repo isn't there.


# New to bolt?

Check these out:

[Installing Bolt](https://puppet.com/docs/bolt/latest/bolt_installing.html)

[Running Bolt commands](https://puppet.com/docs/bolt/latest/running_bolt_commands.html)

[Inventory File Examples](https://puppet.com/docs/bolt/latest/inventory_file_v2.html#inventory-file-examples)

[Bolt Command reference](https://puppet.com/docs/bolt/latest/bolt_command_reference.html)


# Newcomers quickstart

Create a Bolt project + Boltdir > Create Puppetfile + Add this module > Install module > Run tasks! :)

``` shell

mkdir bolt
cd bolt
mkdir Boltdir
cd Boltdir

cat << EOF >> Puppetfile
# Modules from the Puppet Forge.
mod 'kinners00-yum', 	    '0.4.2'
EOF

bolt puppetfile install
```

# Bolt/Puppeteers quickstart

Add this line to your Puppetfile.
<pre>
mod 'kinners00-yum', 	    '0.4.2'
</pre>
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
bolt task run --targets <node-name> yum::security security=<value>
```
## Plan example

**If you a bolt aficionado, you can ignore this section.**

I've included a sample plan to demonstrate how you can chain together tasks to achieve an overall workflow. In this plan we are running the cache task followed by the security task. Tasks within plans can include tasks from other modules. 

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
bolt plan run yum::security_cache targets=<value> cache=<value> security=<value>
```

# Contributions/Feedback

This module contains a simple set of tasks (written in bash) that I created over the space of a day - Nothing crazy. The logic on some tasks could be smarter/cleaner but they should all work. I will get round to improving them at some point in the near future. 

If you're experiencing any bugs, please raise an issue below. 

If anyone would like to contribute to the module, that would be awesome and very much welcomed.

Repo:        https://github.com/kinners00/yum/issues

Issues link: https://github.com/kinners00/yum/issues