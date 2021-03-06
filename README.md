# yum_tasks

#### Table of Contents

1. [Description](#description)
1. [Bolt Quickstart](#bolt-quickstart)
1. [Gotchas/Limitations](#gotchas)
1. [Tasks](#tasks)
    1. [advisory](#advisory)
    1. [cve](#cve)
    1. [security](#security)
    1. [install](#install)
    1. [remove](#remove)
    1. [update](#update)
    1. [update_all](#update_all)
    1. [update_cache](#update_cache)
1. [Plans](#plans)
    1. [security_cache](#security_cache)
    1. [package_cache](#package_cache)
1. [Contributions - Guide for contributing to the module](#contributions)


# Description

These tasks help interact with yum at various levels via Puppet Bolt or Puppet Enterprise tasks. 


# Bolt Quickstart

If you're a bolt aficionado, you can skip this section.

If you've never used bolt before, the easiest way to get started is with a bolt project. Bolt projects allow you to keep/organise your bolt automation in a single space. I've created a skeleton of a bolt project here: https://github.com/kinners00/bolt_sandbox.

1. Download Bolt [here](https://puppet.com/docs/bolt/latest/bolt_installing.html) and install
2. Download/clone repo above
2. Populate your own target inventory information in the ```inventory.yaml``` file (make sure and remove what you don't need and delete #s)
3. Navigate to the ```bolt_sandbox``` directory in your shell
4. Install this module in your project by running ```bolt module add kinners00-yum_tasks```
5. Run ```bolt task show``` and ```bolt plan show``` to find out what tasks and plans are available within this module
6. Running ```bolt <automation_type> show <myautomationitem>``` will give you more detailed info on how to use a given task or plan including required and optional parameters. Try it out by running ```bolt task show yum_tasks::advisory``` within the bolt_sandbox directory/project. As projects are self contained, this command will only work when your current working directory is the ```bolt_sandbox``` directory (```bolt_sandbox-master``` if downloaded). 

Cloned:
```
~/code/bolt_sandbox > bolt task show yum_tasks::advisory
```

Downloaded:
```
~/code/bolt_sandbox-master > bolt task show yum_tasks::advisory
```

Ps. There's some learning/sample tasks and a plan included in the ```bolt_sandbox``` that'll help you get started with building your own tasks and plans. You can start by creating tasks and plans in their relevant directories within the ```bolt_sandbox```!

# Gotchas

### Bolt tasks are copied and executed under /tmp 

If you can't execute scripts under that directory, you can pass ```--tmpdir``` flag on your bolt command followed by your chosen directory for example ```--tmpdir /var/tmp```

### Security related tasks

Security specific tasks leverage the ```yum-security``` plugin. This isn't part of YUM in RHEL6 and will need to be installed before using these tasks. It should be included as standard from RHEL7 and above.

`yum_tasks::security`, `yum_tasks::cve` and `yum_tasks::advisory` tasks will only work if you have the relevant security metadata repos enabled. 

To the best of my knowledge, this effectively limits this task to RHEL and OEL boxes. It will *look* like it works on centos etc (i.e. executes successfully) but it will never "find" any security updates if the corresponding repo isn't there.

### Escalating privilege

Depending on your targets user level permissions, you may have to pass ```--run-as=root``` and ```--sudo-password='mypassword'``` or ```--sudo-password-prompt```  on your bolt command. You can also add ```run-as: root``` and ```sudo-password: 'mypass'``` to your config in your `inventory.yaml` file to enable you keep your bolt command shorter/neater. 

## Example

**Bolt Command**

```
bolt task run yum_tasks::advisory -t rhel advisory="RHSA-2020:5009" --run-as=root --sudo-password='mysudopassword"
```

**inventory.yaml**

```
 groups:
   - name: rhel
     targets:
       - 192.168.1.234
     config:
       transport: ssh
       ssh:
         user: rheluser
         password: 'myregularpassword'
         run-as: root
         sudo-password: 'mysudopassword'
```

# Usage

## Show all available yum tasks

Will show all tasks that match the module name `yum_tasks`.  

```
bolt task show --filter yum_tasks
```

# Tasks

## advisory

```yum_tasks::advisory```

Requires root permissions - see [Escalating privilege](#Escalating-privilege)\
Requires security metadata - see [Security related tasks](#Security-related-tasks)


```
bolt task run yum_tasks::advisory -t <targets> advisory="RHSA-2020:5009"
```

## cve

```yum_tasks::cve```

Requires root permissions - see [Escalating privilege](#Escalating-privilege)\
Requires security metadata - see [Security related tasks](#Security-related-tasks)


```
bolt task run yum_tasks::cve -t <targets> cve="CVE-2019-20907"
```

## security

```yum_tasks::security```

Requires root permissions - see [Escalating privilege](#Escalating-privilege)\
Requires security metadata - see [Security related tasks](#Security-related-tasks)

**minimal**

```
bolt task run yum_tasks::security -t <targets> security=minimal
```


**full**

```
bolt task run yum_tasks::security -t <targets> security=full
```

## install

```yum_tasks::install```

```
bolt task run yum_tasks::install -t <targets> package="vsftpd"
```

## remove

```yum_tasks::remove```

```
bolt task run yum_tasks::remove -t <targets> package="httpd"
```

## update

```yum_tasks::update```

```
bolt task run yum_tasks::update -t <targets> package="httpd"
```

## update_all

```yum_tasks::update_all```

```
bolt task run yum_tasks::update_all -t <targets> 
```

## update_cache

```yum_tasks::update_cache```

**clean**

```
bolt task run yum_tasks::update_cache -t <targets> cache=clean
```

**update**

```
bolt task run yum_tasks::update_cache -t <targets> cache=update
```

# Plans

## security_cache

```yum_tasks::security_cache```

Requires root permissions - see [Escalating privilege](#Escalating-privilege)\
Requires security metadata - see [Security related tasks](#Security-related-tasks)

```
bolt plan run yum_tasks::security_cache targets=<targets> cache=update security=minimal 
```

## package_cache

```yum_tasks::package_cache```

```
bolt plan run yum_tasks::package_cache targets=<targets> cache=update package=nano 
```

# Contributions  

If anyone would like to contribute to the module, that would be awesome and very much welcomed.

If you're experiencing any bugs, please raise an issue below:

Repo:        https://github.com/kinners00/yum_tasks/issues

Issues link: https://github.com/kinners00/yum_tasks/issues