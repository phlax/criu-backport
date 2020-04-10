#!/bin/bash -e

echo "Install procps for test"
apt update
apt install -y -qq procps

cd /tmp

echo "Create a test proc, dumps the date every second"
setsid /tmp/testproc.sh  < /dev/null &> test.log &
PID=$(pgrep -xf "/bin/sh /tmp/testproc.sh")
sleep 1
tail test.log -n 1
sleep 1
tail test.log -n 1

echo "Dump the proc"
mkdir dump
cd dump
criu dump -t $PID

echo "Date should not be updated - test ?"
sleep 1
tail ../test.log -n 1
sleep 1
tail ../test.log -n 1

echo "Restore the proc, date should be updated again - test ?"
criu restore -d
sleep 1
tail ../test.log -n 1
sleep 1
tail ../test.log -n 1
kill -9 $PID
