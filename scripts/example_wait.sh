#!/bin/bash

sleep 2 &
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "Exit status: $?"

sleep 4 &
sleep 10 &
sleep 6 &
wait -n
echo "First job completed."
wait
echo "All jobs completed."
