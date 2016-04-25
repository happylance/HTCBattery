#!/bin/bash
set -e

tail -1 $HOME/logs/htc.log | awk '{print $3}'

