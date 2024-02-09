#!/usr/bin/bash

# for now we just print the command...
for f in tests/* ; 
do
  echo \"python simulator.py "$f"\"
done
