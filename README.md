# mars-git-flow-tools 🛠️

A collection of custom git command-line tools to streamline your workflow, with a flexible, cross-platform installation system.

## Overview

This project provides a set of useful git utilities that can be easily installed on both Windows and Linux/macOS systems. The installation is managed by a central `tools-list.md` file, making it simple to add or remove tools.

## Installation

Choose the appropriate script for your operating system.

### For Linux or macOS

Run the `install.sh` script from your terminal:

```bash
./install.sh
```

The script will install the tools into the `~/bin` directory. It will automatically check for existing tools to prevent duplicates. Make sure that `~/bin` is in your system's `PATH`.

### For Windows

Run the `install.ps1` script from a PowerShell terminal:

```powershell
.\install.ps1
```

The script will install the PowerShell tool scripts into the `$HOME\GitTools` directory. It will provide instructions on how to add this directory to your `Path` environment variable, which is required to run the tools from any location.

## How It Works

- **`tools-list.md`**: This file is the source of truth. It contains a simple list of all available tool names. The installation scripts read this file to determine what to install.
- **`linux/` directory**: Contains the executable shell scripts for Linux and macOS.
- **`windows/` directory**: Contains the PowerShell (`.ps1`) scripts for Windows.

## Creating a New Tool

To simplify the creation of a new tool, you can use the `create-new-flow` scripts.

### For Linux or macOS

```bash
./create-new-flow.sh <your-new-tool-name>
```

### For Windows

```powershell
.\create-new-flow.ps1 <your-new-tool-name>
```

This will:

1. Create a template script in both the `linux/` and `windows/` directories.
2. Automatically add the new tool's name to `tools-list.md`.

You can then edit the newly created files to add your desired functionality.

## Available Tools

| Tool Name           | Functionality                             |
| ------------------ | ------------------------------------ |
| `git-add-worktree` | Automatically create a branch and worktree from main |
| ...                | More tools coming soon                     |

## Installation Alternative

### Linux/macOS

```bash
curl -sL https://github.com/mars-cli/mars-git-tools/raw/main/install.sh | bash
