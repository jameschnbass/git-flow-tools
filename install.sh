#!/bin/bash

# Define the target directory for the git tools
TARGET_DIR="$HOME/bin"

# Get the absolute path of the script's directory to locate source files
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/linux"
TOOL_LIST_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/tools-list.md"

# Ensure the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Creating target directory: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

# Check if tools list file exists
if [ ! -f "$TOOL_LIST_FILE" ]; then
    echo "Error: tools-list.md not found!" >&2
    exit 1
fi

echo "Starting installation for Linux/macOS..."

# Read the tools list, skipping the heading and empty lines
grep -vE '^#|^$' "$TOOL_LIST_FILE" | while IFS= read -r tool_name; do
    # Trim whitespace from the tool name
    tool_name=$(echo "$tool_name" | xargs)
    
    SOURCE_FILE="$SOURCE_DIR/$tool_name"
    TARGET_FILE="$TARGET_DIR/$tool_name"

    if [ -z "$tool_name" ]; then
        continue
    fi

    echo "---"
    echo "Processing tool: $tool_name"

    # Check if the tool is already installed
    if [ -f "$TARGET_FILE" ]; then
        echo "'$tool_name' is already installed in $TARGET_DIR. Skipping."
    else
        # Check if the source file exists
        if [ ! -f "$SOURCE_FILE" ]; then
            echo "Source file not found for '$tool_name' in '$SOURCE_DIR'. Skipping."
        else
            echo "Installing '$tool_name' to $TARGET_DIR..."
            cp "$SOURCE_FILE" "$TARGET_FILE"
            chmod +x "$TARGET_FILE"
            echo "Installation of '$tool_name' complete."
        fi
    fi
done

echo "---"
echo "Installation process finished."
echo
echo "IMPORTANT: Please ensure '$TARGET_DIR' is in your shell's PATH."
echo "You can add it to your .bashrc, .zshrc, or other shell profile file by adding this line:"
echo "export PATH=\"$TARGET_DIR:\$PATH\""

mkdir -p ~/.git-tools
cp ./linux/git-add-worktree ~/.git-tools/
chmod +x ~/.git-tools/git-add-worktree
echo 'export PATH="$HOME/.git-tools:$PATH"' >>~/.bashrc
source ~/.bashrc
echo "✅ 安裝完成，請試試：git add-worktree feature-name"
