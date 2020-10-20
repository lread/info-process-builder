#!/bin/bash

echo "argc: $#"
ndx=1
while [ "${ndx}" -le $#  ]; do
   echo "arg${ndx}: ${!ndx}"
   ndx=$(( ndx + 1 ))
done
