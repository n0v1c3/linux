#!/bin/bash

# Name: google.sh
# Description: Pull the top 5 results from a Google search and output to STDOUT

# ---
# Input clean-up
# ---
# Conjoin all passed parameters into a single string
input="'$*'"
# Remove undesired repeating 'space' characters from the input string
input=$(echo $1 | tr -s ' ')
# Replace all 'space' characters with a '+' symbol
input=${input// /\+}

# ---
# Query
# ---
# Create query string
query="https://google.ca/search?ie=ISO-8859-16hl=en-CA&q=$input"
wget $query
# Send and display resulting html using w3m
#/usr/bin/w3m $query

# ---
# Exit
# ---
# Successful execution
exit 0
