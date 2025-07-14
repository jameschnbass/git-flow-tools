#!/bin/bash

# This script creates the necessary files for a new git flow tool.

if [ -z "$1" ]; then
    echo "Usage: $0 <new-tool-name>" >&2
    exit 1
fi

TOOL_NAME=$1
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LINUX_FILE="$SCRIPT_DIR/linux/$TOOL_NAME"
WINDOWS_FILE="$SCRIPT_DIR/windows/${TOOL_NAME}.ps1"
TOOL_LIST_FILE="$SCRIPT_DIR/tools-list.md"

echo "Creating new flow: $TOOL_NAME"

# Create Linux file
if [ -f "$LINUX_FILE" ]; then
    echo "File already exists: $LINUX_FILE. Skipping."
else
    echo "Creating Linux script: $LINUX_FILE"
    echo -e "#!/bin/bash\n\n# Your script logic here" > "$LINUX_FILE"
    chmod +x "$LINUX_FILE"
fi

# Create Windows file
if [ -f "$WINDOWS_FILE" ]; then
    echo "File already exists: $WINDOWS_FILE. Skipping."
else
    echo "Creating Windows script: $WINDOWS_FILE"
    echo -e "# PowerShell script for $TOOL_NAME\n\n# Your script logic here" > "$WINDOWS_FILE"
fi

# Add to tools-list.md if it's not already there
if grep -q "^$TOOL_NAME$" "$TOOL_LIST_FILE"; then
    echo "'$TOOL_NAME' already in tools-list.md. Skipping."
else
    echo "Adding '$TOOL_NAME' to tools-list.md"
    echo "$TOOL_NAME" >> "$TOOL_LIST_FILE"
fi

echo "---"
echo "Successfully created templates for '$TOOL_NAME'."
echo "Please edit the following files to add your logic:"
echo "- $LINUX_FILE"
echo "- $WINDOWS_FILE"
