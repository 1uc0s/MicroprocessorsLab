#!/bin/bash
# Launch MPLAB X IDE with the current project

# MPLAB X IDE path (adjust version if needed)
MPLAB_PATH="/Applications/microchip/mplabx/v6.25/MPLAB X IDE v6.25.app"

# Get the project directory (where this script is located)
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Launch MPLAB X IDE with the project
open -a "$MPLAB_PATH" "$PROJECT_DIR"

echo "Launching MPLAB X IDE..."
echo "Project directory: $PROJECT_DIR"





