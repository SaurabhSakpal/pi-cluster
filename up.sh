#!/usr/local/bin/bash
ORANGE='\033[38;5;214m'
GREEN='\033[0;32m'
RED='\033[38;5;160m'
NC='\033[0m'

source env
boardname=
ip=

Usage()
{
  echo "Usage : 'up pi_board_name'";
  echo "         Supported pi_board_name names : master | worker_1 | worker_2 | worker_3 | worker_4 | worker_5";
  exit 1;
}

# Validate that there is exactly one input to the script
if [ $# -ne 1 ]; then
    Usage
fi

# read boardname and get the IP address for it
boardname=$1
ip=
if [[ -z ${piMap[$boardname]+"check"} ]];
then
  Usage
else
  ip=${piMap[$boardname]}
fi

if [[ -z $(nmap -p T:22 $ip | grep "Host is up") ]];
then
  echo -e "-- ${RED}$boardname is down${RED}"
else
  echo -e "-- ${GREEN}$boardname is running${NC}"
fi
