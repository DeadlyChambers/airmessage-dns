#!/bin/bash
tail -10 stderr.log > stderr.log
tail -10 stdout.log > stdout.log
_curdate=$(date +"%D %r")
echo -e "${_curdate} - Cleaning up logs"
