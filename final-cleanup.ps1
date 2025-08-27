# Final cleanup script for HTML files

Write-Host "Starting final cleanup for HTML files..."

# Get all HTML files
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

foreach ($file in $htmlFiles) {
    Write-Host "Final cleanup: $($file.Name)"
    
    # Read the file content
    $content = Get-Content $file.FullName -Raw
    
    # Fix remaining issues
    $content = $content -replace " installation TX ", " installation in "
    $content = $content -replace "Bushland IN", "Bushland TX"
    $content = $content -replace "Amarillo IN", "Amarillo TX"
    $content = $content -replace " services TX ", " services in "
    $content = $content -replace "postalCode"": ""79012""", "postalCode"": ""79012"""
    $content = $content -replace "addressLocality"": ""Amarillo""", "addressLocality"": ""Bushland"""
    
    # Make sure Bushland is the primary focus city in service files
    if ($file.Directory.Name -eq "services") {
        $content = $content -replace "addressLocality"": ""[^""]*""", "addressLocality"": ""Bushland"""
    }
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Final cleanup completed!"
