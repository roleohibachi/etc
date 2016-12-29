#!/bin/bash
#A login script for remotely accessed servers
# that attempts to show the user's physical distance from the server
# requires python, curl and python's geopy module

if [ -n "$SSH_CLIENT" ]
then
  set $SSH_CLIENT
  coords=`/usr/bin/curl -s https://ipinfo.io/$1/loc` & \
  mycoords=`/usr/bin/curl -s https://ipinfo.io/loc`
  if [ $coords == "undefined" ]
  then
    /usr/bin/echo "Your last hop is $1"
  else
  	/usr/bin/python -c "from geopy.distance import vincenty;start=('$coords');end=('$mycoords');print('Your last hop is ' + str(format(vincenty(start,end).miles,'.2f')) + ' miles away.')"
  fi
fi
