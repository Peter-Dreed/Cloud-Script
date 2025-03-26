# Define the output CSV file path
$outputFile = "$env:USERPROFILE\Desktop\TOPGUN.csv"

# Check if CSV exists, if not, create it with headers
if (-not (Test-Path $outputFile)) {
    "Timestamp,CPU_Usage,Available_Memory_MB,Memory_Percentage" | Out-File -FilePath $outputFile -Encoding utf8
}

# Start monitoring in a loop
while ($true) {
    # Get timestamp
    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    # Get CPU usage
    $cpuTime = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue

    # Get available memory
    $availMem = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
    
    # Get total RAM
    $totalRam = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).Sum

    # Calculate memory percentage
    $memPercentage = (104857600 * $availMem / $totalRam)

    # Display output in console
    Write-Host "$date > CPU: $($cpuTime.ToString("#,0.000"))%, Avail. Mem.: $($availMem.ToString("N0"))MB ($($memPercentage.ToString("#,0.0"))%)"

    # Format output for CSV
    "$date,$($cpuTime.ToString("#,0.000")),$($availMem.ToString("N0")),$($memPercentage.ToString("#,0.0"))" | Out-File -FilePath $outputFile -Append -Encoding utf8

    # Sleep for 5 seconds
    Start-Sleep -Seconds 5
}
