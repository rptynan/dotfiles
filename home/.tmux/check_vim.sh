#!/usr/bin/env bash

# From https://github.com/christoomey/vim-tmux-navigator/issues/406#issuecomment-2409134805

# Get the current TTY from tmux
current_tty=$(tmux display-message -p '#{pane_tty}')
current_tty=${current_tty#/dev/} # Remove '/dev/' prefix

# Get the PIDs of processes associated with the current TTY
pids=$(ps -o pid= -t "$current_tty")
pids=($(echo "$pids")) # Convert to an array

# Initialize a set of all descendant PIDs
all_pids=("${pids[@]}")

# Initialize the list of PIDs to process
to_process=("${pids[@]}")

# Loop to find all descendant processes iteratively
while [ ${#to_process[@]} -gt 0 ]; do
  # Get the child PIDs of the current PIDs
  # This version I hacked to get it working on macOS
  child_pids=$(ps -eo pid=,ppid= | awk -v parents="${to_process[*]}" '
    BEGIN {
      n = split(parents, arr, " ")
      for (i = 1; i <= n; i++) parent[arr[i]] = 1
    }
    parent[$2] { print $1 }
  ')
  # This is the original from github
  # child_pids=($(echo "$child_pids"))
  #   echo ${to_process[*]}
  #   child_pids=$(ps --no-headers -o pid= --ppid $(
  #     IFS=','
  #     echo "${to_process[*]}"
  #   ))

  # Remove leading/trailing whitespace and convert to array
  child_pids=($(echo "$child_pids"))
  # Break the loop if no more child processes are found
  if [ ${#child_pids[@]} -eq 0 ]; then
    break
  fi
  # Add child PIDs to the set of all_pids
  all_pids+=("${child_pids[@]}")
  # Update to_process with the new child PIDs
  to_process=("${child_pids[@]}")
done

# Remove duplicate PIDs
all_pids_unique=($(printf "%s\n" "${all_pids[@]}" | sort -u))

# Join all PIDs into a comma-separated list for ps
pid_list=$(
  IFS=','
  echo "${all_pids_unique[*]}"
)

# Get the state and command of all descendant processes
ps_output=$(ps -o state= -o comm= -p "$pid_list")

# Check if any of the processes match the regex
echo "$ps_output" | grep -iqE '^[^TXZ ]+ +(\S+/)?g?(view|l?n?vim?x?|fzf)(diff)?$'

# Store the exit status
is_vim_running=$?

# Exit with the appropriate status
exit $is_vim_running
