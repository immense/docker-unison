#!/bin/sh
export HOME=/root
cd /code
exec unison -socket 5000 >>/var/log/unison.log 2>&1
