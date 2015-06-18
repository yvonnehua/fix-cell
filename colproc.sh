#!/bin/bash

for col in `seq 2 11`
do
  bsub -n 4 -W 1:59 -q sorger_2h matlab -nosplash -nodesktop -r "colproc('${1}', ${col})"
done
