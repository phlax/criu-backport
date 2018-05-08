#!/bin/sh


# theres a leaking fd on travis - this seems very arbitrary, but not sure how
# else to find/purge it
FD=$(lsof -p $$ | grep "136,0" | tr -s ' ' | cut -d" " -f4  | sed 's/[^0-9]*//g')
exec $FD>&-

while :; do
    sleep 1
    date
done
