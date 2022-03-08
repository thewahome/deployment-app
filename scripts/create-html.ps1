$url = "$($URL)"
Write-Host "URL: $url"
$htmlContent = Invoke-WebRequest $url | Select-Object -ExpandProperty Content
Write-Host "Pipeline = $($htmlContent)"

$buildFile = '../public/index.html'
$content = Get-Content -Path $buildFile -Raw 
$html = New-Object -ComObject "HTMLFile"
$html.IHTMLDocument2_write($content)
$scripts = $html.all.tags('script') | ForEach-Object src

$scriptTags = ''
foreach ($source in $scripts) {
  $scriptTags += "<script src='$source'></script>"
}
$scriptTags += '</head>'

$htmlContent -replace '</head>', $scriptTags | 
Set-Content $buildFile -Force
$htmlContent