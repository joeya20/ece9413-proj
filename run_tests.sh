#!/usr/bin/bash

# for now we just print the command...
for f in tests/* ; 
do
  echo \"python skeleton.py "$f"\"
done
