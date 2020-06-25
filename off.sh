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
  echo "Usage : 'off pi_board_name'";
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

#shutdown the pi board
echo -e "-- ${ORANGE}shutting down $boardname${NC}"
ssh $boardname "sudo shutdown -h +1; exit;" &> /dev/null
if [[ $? -ne 0 ]];
then
  echo -e "-- ${RED}$boardname shutdown failed${RED}"
else
  echo -e "-- ${GREEN}$boardname successfully shutdown${NC}"
fi
