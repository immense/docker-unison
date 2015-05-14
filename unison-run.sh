#!/bin/sh
export HOME=/root
cd /code
rm -rf ./*
rm -rf ~/.unison
exec unison -socket 5000 >>/var/log/unison.log 2>&1
