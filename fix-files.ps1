# PowerShell script to update all HTML files properly
# More precise replacements to avoid errors

Write-Host "Starting HTML file updates for Bushland, TX project..."

# Get all HTML files
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

Write-Host "Found $($htmlFiles.Count) HTML files to update..."

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    # Read the file content
    $content = Get-Content $file.FullName -Raw
    
    # First pass: Fix the errors from previous script
    $content = $content -replace "TXitial-scale", "initial-scale"
    $content = $content -replace " services TX ", " services in "
    $content = $content -replace "Amarillo IN", "Amarillo TX"
    
    # City name replacements
    $content = $content -replace "\bHuntertown\b", "Bushland"
    $content = $content -replace "\bAlbion\b", "Amarillo"
    $content = $content -replace "\bAngola\b", "Hereford"
    $content = $content -replace "\bAuburn\b", "Wildorado"
    $content = $content -replace "\bAvilla\b", "Levelland"
    $content = $content -replace "\bButler\b", "Happy"
    $content = $content -replace "\bChurubusco\b", "Plainview"
    $content = $content -replace "\bColumbia City\b", "Floydada"
    $content = $content -replace "\bFremont\b", "Dimmitt"
    $content = $content -replace "\bGarrett\b", "Vega"
    $content = $content -replace "\bGrabill\b", "Claude"
    $content = $content -replace "\bKendallville\b", "Friona"
    $content = $content -replace "\bLigonier\b", "Muleshoe"
    $content = $content -replace "\bMonroeville\b", "Borger"
    $content = $content -replace "\bNew Haven\b", "Canyon"
    $content = $content -replace "\bRoanoke\b", "Lockney"
    $content = $content -replace "\bRome City\b", "Littlefield"
    $content = $content -replace "\bWaterloo\b", "Tulia"
    $content = $content -replace "\bWoodburn\b", "Panhandle"
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    
    Write-Host "Updated: $($file.Name)"
}

Write-Host "All files have been updated successfully!"
