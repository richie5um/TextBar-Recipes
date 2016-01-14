#!/bin/bash

# This script uses "top" for getting LOAD-stats
# It's only tested on OS X "El Capitan"
#
# 2016-01-14 Kai Laufer

echo $(top -l 1 | grep "Load Avg:")
