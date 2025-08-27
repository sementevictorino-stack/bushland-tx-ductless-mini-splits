# PowerShell script to update all HTML files from Indiana locations to Texas locations
# CATEGORY = Ductless Mini split, CITY = bushland, STATE = TX, Full = bushland TX

# Define the mapping of old Indiana cities to new Texas cities
$cityMappings = @{
    'Huntertown' = 'Bushland'
    'Fort Wayne' = 'Amarillo'
    'New Haven' = 'Canyon'
    'Woodburn' = 'Panhandle'
    'Grabill' = 'Claude'
    'Auburn' = 'Wildorado'
    'Garrett' = 'Vega'
    'Butler' = 'Happy'
    'Waterloo' = 'Tulia'
    'Angola' = 'Hereford'
    'Fremont' = 'Dimmitt'
    'Kendallville' = 'Friona'
    'Ligonier' = 'Muleshoe'
    'Albion' = 'Amarillo'
    'Rome City' = 'Littlefield'
    'Avilla' = 'Levelland'
    'Churubusco' = 'Plainview'
    'Columbia City' = 'Floydada'
    'Roanoke' = 'Lockney'
    'Monroeville' = 'Borger'
}

# Define replacement patterns
$replacements = @{
    # Basic state/region replacements
    ', IN' = ', TX'
    ', Indiana' = ', Texas'
    ' IN ' = ' TX '
    ' Indiana ' = ' Texas '
    'northeastern Indiana' = 'Texas Panhandle'
    'Allen County' = 'Potter County'
    'Fort Wayne metropolitan area' = 'Amarillo metropolitan area'
    'zip codes 46748 and 46845' = 'Potter County area'
    'zip codes 46748, 46845' = 'Potter County area'
    '46748' = '79012'
    '46845' = '79012'
    '46701' = '79101'
    '46805' = '79101'
    "Indiana's" = "Texas'"
    'IN"' = 'TX"'
    
    # Coordinate replacements (Indiana to Texas Panhandle)
    'latitude": 41.1306' = 'latitude": 35.1863'
    'longitude": -85.1394' = 'longitude": -102.0954'
    'latitude": 41.0793' = 'latitude": 35.2220'
    'longitude": -85.4236' = 'longitude": -101.8313'
    'latitude": 41.3928' = 'latitude": 35.2220'
    
    # Address replacements
    '12845 Coldwater Road' = '1234 Main Street'
    '3402 Fairfield Avenue' = '2301 South Western Street'
    '211 East Main Street' = '2301 South Western Street'
    
    # Climate references
    "Indiana's varied climate" = "Texas Panhandle's varied climate"
    "Indiana's climate" = "Texas Panhandle climate"
    "Huntertown's continental climate" = "Bushland's semi-arid climate"
    "hot, humid summers" = "hot summers"
    "Indiana's coldest months" = "Texas Panhandle's coldest months"
    "West Texas" = "West Texas"
}

# Get all HTML files
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

Write-Host "Found $($htmlFiles.Count) HTML files to update..."

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.FullName)"
    
    # Read the file content
    $content = Get-Content $file.FullName -Raw
    
    # Apply city-specific replacements
    foreach ($oldCity in $cityMappings.Keys) {
        $newCity = $cityMappings[$oldCity]
        $content = $content -replace "\b$oldCity\b", $newCity
    }
    
    # Apply general replacements
    foreach ($pattern in $replacements.Keys) {
        $replacement = $replacements[$pattern]
        $content = $content -replace [regex]::Escape($pattern), $replacement
    }
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    
    Write-Host "Updated: $($file.Name)"
}

Write-Host "All files have been updated successfully!"
