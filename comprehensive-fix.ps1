# Comprehensive final fix script

Write-Host "Applying comprehensive final fixes..."

# Get all HTML files
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

foreach ($file in $htmlFiles) {
    # Read the file content
    $content = Get-Content $file.FullName -Raw
    
    # Fix coordinate issues (replace old Indiana coordinates with Texas coordinates)
    $content = $content -replace 'latitude": 41\.2228', 'latitude": 35.1863'
    $content = $content -replace 'longitude": -85\.1694', 'longitude": -102.0954'
    
    # Fix content issues
    $content = $content -replace " service TX ", " service in "
    $content = $content -replace "installation TX ", "installation in "
    $content = $content -replace " HVAC service TX ", " HVAC service in "
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Comprehensive fixes completed!"
