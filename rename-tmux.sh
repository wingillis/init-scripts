#!/bin/bash

if [[ $(hostname) == *"rc.hms.harvard.edu" ]]; then
  mv ~/.tmux.conf ~/.tmux.conf.slurm
elif [[ $(hostname -f ) == *"orchestra"* ]]; then
  mv ~/.tmux.conf ~/.tmux.conf.orchestra
fi
