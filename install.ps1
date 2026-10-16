<#
.SYNOPSIS
    Install TRAE skills to project or global directory.
.DESCRIPTION
    Copy skills from this repository to .trae/skills (project) or
    ~/.marscode/builtin/global/skills (global).
.PARAMETER Target
    Install target: 'project' (default) or 'global'.
.PARAMETER Skill
    Specific skill name to install. If empty, install all skills.
.EXAMPLE
    .\install.ps1
    .\install.ps1 -Target global
    .\install.ps1 -Skill skill-creator
#>

param(
    [ValidateSet("project", "global")]
    [string]$Target = "project",
    
    [string]$Skill = ""
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if ($Target -eq "global") {
    $destRoot = Join-Path $env:USERPROFILE ".marscode\builtin\global\skills"
} else {
    $currentDir = Get-Location
    $destRoot = Join-Path $currentDir ".trae\skills"
}

if (-not (Test-Path $destRoot)) {
    New-Item -ItemType Directory -Path $destRoot -Force | Out-Null
    Write-Host "[OK] Created: $destRoot"
}

$allSkills = @()
$items = Get-ChildItem -Path $scriptDir -Directory
foreach ($item in $items) {
    $name = $item.Name
    if ($name -eq ".git") { continue }
    $skillMdPath = Join-Path $item.FullName "SKILL.md"
    if (Test-Path $skillMdPath) {
        $allSkills += @{ Name = $name; FullName = $item.FullName }
    }
}

if ($Skill -ne "") {
    $filtered = @()
    foreach ($s in $allSkills) {
        if ($s.Name -eq $Skill) {
            $filtered += $s
        }
    }
    $allSkills = $filtered
    
    if ($allSkills.Count -eq 0) {
        Write-Host "[ERROR] Skill not found: $Skill"
        Write-Host "Available skills:"
        $items = Get-ChildItem -Path $scriptDir -Directory
        foreach ($item in $items) {
            $n = $item.Name
            if ($n -eq ".git") { continue }
            $md = Join-Path $item.FullName "SKILL.md"
            if (Test-Path $md) {
                Write-Host "  - $n"
            }
        }
        exit 1
    }
}

Write-Host ""
Write-Host "Target: $destRoot"
Write-Host "----------------------------------------"

$count = 0
foreach ($s in $allSkills) {
    $destPath = Join-Path $destRoot $s.Name
    
    if (Test-Path $destPath) {
        Remove-Item -Path $destPath -Recurse -Force
        Write-Host "[OVERWRITE] $($s.Name)"
    } else {
        Write-Host "[INSTALL] $($s.Name)"
    }
    
    Copy-Item -Path $s.FullName -Destination $destPath -Recurse -Force
    $count++
}

Write-Host "----------------------------------------"
Write-Host "[DONE] Installed $count skill(s) to: $destRoot"
Write-Host ""