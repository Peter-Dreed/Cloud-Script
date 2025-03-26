# Define the output CSV file path
$outputFile = "$env:USERPROFILE\Desktop\Event.csv"

# Get event logs (Modify LogName if needed: Application, System, Security, etc.)
$eventLogs = Get-WinEvent -LogName Application -MaxEvents 5 | Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, Message

# Export to CSV
$eventLogs | Export-Csv -Path $outputFile -NoTypeInformation

# Notify the user
Write-Host "Event logs have been saved to: $outputFile"
