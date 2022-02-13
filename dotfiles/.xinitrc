#!/bin/sh
exec >> ~/.xsession-errors 2>&1
. ~/.xprofile
exec i3
