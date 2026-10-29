#!/usr/bin/env bash
set -euo pipefail

read -r -p "Enter the principal amount: " principal
read -r -p "Enter the annual rate of interest (%): " rate
read -r -p "Enter the time period (years): " time

# Validate that the inputs are non-negative numbers.
for value in "$principal" "$rate" "$time"; do
  if [[ ! "$value" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    echo "Error: please enter non-negative numeric values only." >&2
    exit 1
  fi
done

interest=$(awk -v p="$principal" -v r="$rate" -v t="$time" 'BEGIN { printf "%.2f", (p*r*t)/100 }')
total=$(awk -v p="$principal" -v i="$interest" 'BEGIN { printf "%.2f", p+i }')

echo "Simple Interest: $interest"
echo "Total Amount: $total"
