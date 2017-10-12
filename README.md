# hadoop-skeleton

A hadoop streaming skeleton shell script for messy statistical tasks, it's sample and easy to use.


Getting Started
----------------

### Create Task

`./jarvis.sh -m {module} -i {item}`

This command will create a task config file `./task/{module}/{item}.conf`, and a map&reduce script `./task/{module}/{item}/[map|reduce].py`

### Edit config and map&reduce script

edit global config `./main.conf`

edit `./task/{module}/{item}.conf` to do some basic configuration.

edit `./task/{module}/{item}/[map|reduce].py`. at last, `run.sh` will auto add `-file` option for this file. This step is optional, sample map&reduce also can set in the task config file.

### Run Task

`./run.sh -m {module} -i {item}`
