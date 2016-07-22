#!/bin/bash

# Get input as parameter

# Encode input as qr and display in terminal
qrencode -t ASCII "$@" | cat | sed "s/#/█/g"
