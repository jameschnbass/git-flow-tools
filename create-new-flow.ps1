# This script creates the necessary files for a new git flow tool.

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$ToolName
)

$ScriptDir = Split-Path $MyInvocation.MyCommand.Path
$LinuxFile = Join-Path $ScriptDir "linux\$ToolName"
$WindowsFile = Join-Path $ScriptDir "windows\$($ToolName).ps1"
$ToolListFile = Join-Path $ScriptDir "tools-list.md"

Write-Host "Creating new flow: $ToolName"

# Create Linux file
if (Test-Path $LinuxFile) {
    Write-Host "File already exists: $LinuxFile. Skipping."
} else {
    Write-Host "Creating Linux script: $LinuxFile"
    "#!/bin/bash`n`n# Your script logic here" | Set-Content -Path $LinuxFile
}

# Create Windows file
if (Test-Path $WindowsFile) {
    Write-Host "File already exists: $WindowsFile. Skipping."
} else {
    Write-Host "Creating Windows script: $WindowsFile"
    "# PowerShell script for $ToolName`n`n# Your script logic here" | Set-Content -Path $WindowsFile
}

# Add to tools-list.md if it's not already there
$toolExists = Get-Content $ToolListFile | Select-String -Pattern "^$ToolName$" -Quiet
if ($toolExists) {
    Write-Host "'$ToolName' already in tools-list.md. Skipping."
} else {
    Write-Host "Adding '$ToolName' to tools-list.md"
    Add-Content -Path $ToolListFile -Value $ToolName
}

Write-Host "---"
Write-Host "Successfully created templates for '$ToolName'."
Write-Host "Please edit the following files to add your logic:"
Write-Host "- $LinuxFile"
Write-Host "- $WindowsFile"
