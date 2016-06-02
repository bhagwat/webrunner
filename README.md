# Web runner

Spring boot has a nice feaure of generating executable `JAR` with embedded tomcat. Only the java runtime needs to be available on that machine on which you want to run the executable jar. Grails 3.x framework based on Spring boot inherits the same.

The web runner scripts is Shell scripts for running web processes in background using `nohup` command line tool. It manages the pid file and takes care of starting/stopping the process automatically and managing server logs.

## start.sh

Main entry point for running the application in background. It stops the existing running application by reading the pid file if any. It looks for latest.jar file by default and if it is not found then it aborts the deployment script.

```
$ cd webrunner
$ ./start.sh # Fails if there is no latest.jar file in current directory
```

## stop.sh 

It stops the running process whose pid is found in run.pid file. This shell script can be used with any process type. If you have different pid file then just pass it as an arguement. It will use the commandline file name to find the PID.

```
$ cd webrunner
$ ./stop.sh # Looks for run.pid file in current directory
$ ./stop.sh myprocess.file # Looks for pid in myprocess.file
```

## env.sh

For externalised configurations, define application specific environment variables in this file. `start.sh` script will automatically reload all the changes from this file whenever you restart the application. You are free to define evnrionment variables independently at statndard locations like e.g. `.bashrc` or `.profile` fiiles, however you will have to make sure that those changes are sourced and available.

e.g.

```
export PORT=8090 # default is 8080
export GRAILS_ENV=staging #default is production
export LATEST_WAR_NAME=latest.jar # Jar file for deployment
```


