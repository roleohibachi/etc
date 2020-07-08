#!/bin/bash
#A login script for remotely accessed servers
# that attempts to show the user's physical distance from the server
# requires python, curl and python's geopy module

if [ -n "$SSH_CLIENT" ]
then
  set $SSH_CLIENT

  #room for performance improvement here, if you can figure out how to parallelize.
  #and dont write to a file, thats cheating.
  #Possibly by backgrounding them as jobs, then using a while loop to wait for both to be populated?
  CLIENTLOC=$(/usr/bin/curl -s https://ipinfo.io/$1/loc )
  SERVERLOC=$(/usr/bin/curl -s https://ipinfo.io/loc )

    if [ $CLIENTLOC == "undefined" ]; then
      if [ $(dig +short -x $1) ]; then
        /usr/bin/echo "Your last hop is $(dig +short -x $1)"
      else
        /usr/bin/echo "Your last hop is $1."
      fi
  else
    /usr/bin/python -c "from geopy.distance import vincenty;start=('$CLIENTLOC');end=('$SERVERLOC');print('Your last hop is ' + str(format(vincenty(start,end).miles,'.2f')) + ' miles away.')"
  fi
fi

