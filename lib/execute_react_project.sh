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

# Function to run a React project
execute_react_project() {
    local project="$1"
    local port="$2"
    
    echo "Detected React project"

    check_and_stop_process "$port"
    
    # Change to the React project directory
    cd "$project" || {
        echo "Error: Failed to change directory to '$project'."
        return 1
    }
    
    # Run the React command in the background on the specified port
    npm install || {
    echo "Error: Failed to execute 'npm install' in '$project'."
    exit 1
    }

    npm run build

    node server.js --port="$port" &
}