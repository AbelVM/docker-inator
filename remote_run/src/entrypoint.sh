#!/bin/bash

tstamp() { date +[%T:%N]; }

echo "$(tstamp) - START"

IFS=':' read -r -a sarray <<< "$STEPS"

IFS=':' read -r -a carray <<< "$MY_ITERATOR"
for country in "${carray[@]}"
do

    # GLOBALS
    export -f tstamp
    set -a
        db="geospatial_$country"
    set +a

    # Steps block
    step=1
    if [[ " ${sarray[@]} " =~ " ${step} " || " ${sarray[@]} " =~ " all " ]]
    then
        echo "$(tstamp) - [${country}] Step $step: Step description"
        source ./bash/step_01.sh
    else
        echo "$(tstamp) - [${country}] Skipping step $step"
    fi

    # Done
    echo "$(tstamp) - [${country}] Done"

done

echo "$(tstamp) - FINISH"
