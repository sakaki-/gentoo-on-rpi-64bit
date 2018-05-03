#!/bin/bash -e
if [ -z "$NETWORK" ]; then 
    net=10.0.0.1/16
else
    net=$NETWORK
fi

append_params=""

if [ -n "$JOBS" ]; then
    append_params="$append_params --jobs $JOBS"
fi

distccd --allow=$net --daemon --verbose --no-detach $append_params
