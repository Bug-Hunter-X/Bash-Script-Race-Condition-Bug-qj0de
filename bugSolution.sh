#!/bin/bash

# This script demonstrates a solution to the race condition bug.
# It uses flock to ensure that only one process can access the counter file at a time.

counter_file="counter.txt"
echo "0" > "$counter_file"

process1() {
  for i in {1..1000}; do
    flock -n -x "$counter_file" || exit 1
    value=$(cat "$counter_file")
    ((value++))
    echo "$value" > "$counter_file"
    flock -u "$counter_file"
  done
}

process2() {
  for i in {1..1000}; do
    flock -n -x "$counter_file" || exit 1
    value=$(cat "$counter_file")
    ((value++))
    echo "$value" > "$counter_file"
    flock -u "$counter_file"
  done
}

# Run both processes concurrently
process1 & process2 & wait

# Print final value from the counter file
final_value=$(cat "$counter_file")
echo "Final value: $final_value"