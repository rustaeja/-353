#! /bin/bash

TIMEOUT=55
HOST="localhost:8080"
URL_PATH=/aprenda/regex/task/0
export JETTY_HOME="/home/ubuntu/jetty"

echo -n "$(date +%Y%m%d-%H:%M:%S) Verificando se games responde: "

if [ -z "$(curl --connect-timeout $TIMEOUT -m $TIMEOUT -vv http://$HOST$URL_PATH 2>&1 | grep "200 OK")" ]; then 
	echo "Fail! Rebooting!"
	
	$JETTY_HOME/bin/jetty.sh stop
	
	sleep 3
	kill -9 $(jps -l | grep start.jar | cut -d " " -f 1)
	
	$JETTY_HOME/bin/jetty.sh start
else
	echo "Ok!"
fi;
]
