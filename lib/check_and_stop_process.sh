#!/bin/bash

# Automated Project Runner
# Copyright (C) 2024 Eduardo Aguilar AST
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Function to check and stop the process on a specific port
check_and_stop_process() {
    local port="$1"
    local process_info=$(netstat -ano | grep ":$port" | grep "LISTENING")
    
    # Check if there is any process on the port
    if [ -n "$process_info" ]; then
        # Iterate over each line of process information
        while IFS= read -r line; do
            # Extract the PID of the process
            local pid=$(echo "$line" | awk '{print $NF}' | tr -d '[:space:]')
            echo "$pid"
            # Stop the process
            kill $pid
            powershell.exe -Command "taskkill /F /PID "$pid""
            echo "Process stopped on port $port"
        done <<< "$process_info"
    else
        echo "No processes on port $port" 
    fi
}
