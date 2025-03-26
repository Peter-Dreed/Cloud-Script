# Function to delete temp files
function Clear-TempFiles {
    Write-Host "Deleting temporary files..." -ForegroundColor Yellow
    $tempPaths = @("$env:TEMP", "$env:WINDIR\Temp")

    foreach ($path in $tempPaths) {
        if (Test-Path $path) {
            Get-ChildItem -Path $path -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        }
    }
    Write-Host "Temporary files deleted!" -ForegroundColor Green
}

# Function to restart essential services
function Restart-Services {
    Write-Host "Restarting critical services..." -ForegroundColor Yellow
    $services = @("Spooler", "wuauserv", "bits", "Winmgmt") # Add more if needed

    foreach ($service in $services) {
        if (Get-Service -Name $service -ErrorAction SilentlyContinue) {
            Restart-Service -Name $service -Force
            Write-Host "$service restarted!" -ForegroundColor Green
        }
    }
}

# Function to clear memory usage
function Clear-Memory {
    Write-Host "Clearing memory cache..." -ForegroundColor Yellow
    [System.GC]::Collect()
    Write-Host "Memory optimized!" -ForegroundColor Green
}

# Run functions
Clear-TempFiles
Restart-Services
Clear-Memory

Write-Host "System optimization completed!" -ForegroundColor Cyan
