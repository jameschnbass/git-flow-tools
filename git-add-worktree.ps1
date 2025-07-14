param (
    [string]$branch
)

if (-not $branch) {
    Write-Error "❌ 請輸入分支名稱：git add-worktree <branch-name>"
    exit 1
}

$dir = "..\$branch"

git switch main 2>$null
if ($LASTEXITCODE -ne 0) {
    git checkout main
}

if (-not (Test-Path $dir)) {
    New-Item -Path $dir -ItemType Directory | Out-Null
}

# 檢查分支是否存在
$branchExists = git branch --list $branch

if (-not $branchExists) {
    Write-Host "🌱 建立新分支 '$branch' 自 main"
    git branch $branch main
}
else {
    Write-Host "✅ 分支 '$branch' 已存在"
}

if (Test-Path "$dir\.git") {
    Write-Host "📂 Worktree 已存在：$dir"
}
else {
    git worktree add $dir $branch
    Write-Host "🚀 Worktree 建立成功：$dir"
}
