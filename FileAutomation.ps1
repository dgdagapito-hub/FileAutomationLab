$sourceFolder  = Join-Path $PSScriptRoot "SampleFiles"
$archiveFolder = Join-Path $PSScriptRoot "Archive"
$daysOld       = 7

$cutoffDate = (Get-Date).AddDays(-$daysOld)
Write-Host "Cutoff date: $cutoffDate"

if (-not (Test-Path $archiveFolder)) {
    New-Item -Path $archiveFolder -ItemType Directory | Out-Null
}

$oldFiles = Get-ChildItem -Path $sourceFolder -File |
    Where-Object { $_.LastWriteTime -lt $cutoffDate }

Write-Host "Found $($oldFiles.Count) file(s) older than $daysOld days."

foreach ($file in $oldFiles) {
    Move-Item -Path $file.FullName -Destination $archiveFolder -WhatIf
}

Write-Host "Script completed successfully."