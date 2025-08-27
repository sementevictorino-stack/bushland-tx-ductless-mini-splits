# Targeted fix for specific remaining issues

Write-Host "Applying targeted fixes..."

# Get all HTML files
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

foreach ($file in $htmlFiles) {
    # Read the file content
    $content = Get-Content $file.FullName -Raw
    
    # Specific targeted fixes
    $content = $content -replace "installation TX Bushland", "installation in Bushland"
    $content = $content -replace "installation Bushland IN", "installation Bushland TX"
    $content = $content -replace """addressLocality"":\s*""Amarillo""", """addressLocality"": ""Bushland"""
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Targeted fixes completed!"
