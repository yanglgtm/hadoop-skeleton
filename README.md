# hadoop-skeleton

A hadoop streaming skeleton shell script for messy statistical tasks, it's sample and easy to use.


Getting Started
----------------

### set config

set global config `./main.conf`

create task config `./conf.d/{module}/{item}.conf`

### add map&reduce script

The code path is `./src/{module}/{item}/`, then the script will auto add `-file` option for this file.

This step is optional, sample map&reduce also can set in task config file.

### run task

`run.sh -m {module} -i {item}`
