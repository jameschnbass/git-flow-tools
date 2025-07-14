# Define the target directory for the git tools
$TargetDir = "$HOME\GitTools"

# Get the absolute path of the script's directory to locate source files
$SourceDir = (Get-Item (Join-Path (Split-Path $MyInvocation.MyCommand.Path) 'windows')).FullName
$ToolListFile = (Get-Item (Join-Path (Split-Path $MyInvocation.MyCommand.Path) 'tools-list.md')).FullName

# Ensure the target directory exists
if (-not (Test-Path -Path $TargetDir)) {
    Write-Host "Creating target directory: $TargetDir"
    New-Item -ItemType Directory -Path $TargetDir | Out-Null
}

# Check if tools list file exists
if (-not (Test-Path -Path $ToolListFile)) {
    Write-Error "Error: tools-list.md not found!"
    exit 1
}

Write-Host "Starting installation for Windows..."

# Read the tools list, skipping the heading and empty lines
Get-Content $ToolListFile | Where-Object { $_ -notmatch '^#|^$' } | ForEach-Object {
    $tool_name = $_.Trim()

    if ([string]::IsNullOrWhiteSpace($tool_name)) {
        return # continue
    }

    # For Windows, we assume the scripts are PowerShell files (.ps1)
    $SourceFile = Join-Path $SourceDir "$($tool_name).ps1"
    $TargetFile = Join-Path $TargetDir "$($tool_name).ps1"

    Write-Host "---"
    Write-Host "Processing tool: $tool_name"

    # Check if the tool is already installed
    if (Test-Path -Path $TargetFile) {
        Write-Host "'$tool_name' is already installed in $TargetDir. Skipping."
    } else {
        # Check if the source file exists
        if (-not (Test-Path -Path $SourceFile)) {
            Write-Host "Source file not found for '$tool_name' at '$SourceFile'. Skipping."
        } else {
            Write-Host "Installing '$tool_name' to $TargetDir..."
            Copy-Item -Path $SourceFile -Destination $TargetFile
            Write-Host "Installation of '$tool_name' complete."
        }
    }
}

Write-Host "---"
Write-Host "Installation process finished."
Write-Host "`nIMPORTANT: To run these tools from anywhere, please ensure '$TargetDir' is in your PATH environment variable."
Write-Host "You can check your current user PATH by running:"
Write-Host '    [Environment]::GetEnvironmentVariable("Path", "User")'
Write-Host "To add it (if it's not there), you can run the following command in an ELEVATED (Administrator) PowerShell terminal:"
Write-Host '    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")'
Write-Host '    $newPath = "$currentPath;$TargetDir"'
Write-Host '    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")'
Write-Host "After running the command, you MUST restart your terminal for the changes to take effect."

New-Item -ItemType Directory -Force -Path $target | Out-Null
Copy-Item -Path ./windows/git-add-worktree.ps1 -Destination $target

$envPath = [System.Environment]::GetEnvironmentVariable("PATH", "User")
if ($envPath -notlike "*GitTools*") {
    [System.Environment]::SetEnvironmentVariable("PATH", "$envPath;$target", "User")
}

Write-Host "✅ 安裝完成，請試試：git-add-worktree.ps1 feature-name"
