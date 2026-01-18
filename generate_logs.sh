#!/bin/bash

# Generate 5000 sample log entries
for i in {1..5000}; do 
  echo "$(date -d "$i seconds ago") [$(shuf -e ERROR WARN INFO -n1)] Service response time: ${RANDOM}ms" >> practice.log
done

echo "Generated 5000 log entries in practice.log"