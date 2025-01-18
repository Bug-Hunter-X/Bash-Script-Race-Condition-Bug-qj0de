#!/bin/bash

# This script demonstrates a race condition bug.
# It uses two processes to concurrently update a counter in a file.

counter_file="counter.txt"
echo "0" > "$counter_file"

process1() {
  for i in {1..1000}; do
    value=$(cat "$counter_file")
    ((value++))
    echo "$value" > "$counter_file"
  done
}

process2() {
  for i in {1..1000}; do
    value=$(cat "$counter_file")
    ((value++))
    echo "$value" > "$counter_file"
  done
}

# Run both processes concurrently
process1 & process2 & wait

# Print final value from the counter file.  The expected value is 2000, but due to the race condition, it is likely less.
final_value=$(cat "$counter_file")
echo "Final value: $final_value"