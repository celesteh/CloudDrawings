#!/bin/bash

echo "remember for next time to run this as a source"

source stylus_script.sh
jack_script.sh

# is supercollider running?
if ps aux | grep -vi grep | grep -q scide
  then
	echo already running
  else
	scide CloudDrawings.scd &
fi

