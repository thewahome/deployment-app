$url = "https://gewayhome.z13.web.core.windows.net/cdf4e7f84c05e9f757dab037bc354d22739cc09d"
Write-Host "URL: $url"
$htmlContent = Invoke-WebRequest $url | Select-Object -ExpandProperty Content

$buildFile = '../build/index.html'
$content = Get-Content -Path $buildFile -Raw 
$html = New-Object -ComObject "HTMLFile"
$html.IHTMLDocument2_write($content)

$scripts = $html.all.tags('script') | ForEach-Object src
$cssLinks = $html.all.tags('link') |
Where-Object { $_.rel -eq 'stylesheet' } |
Select-Object -Expand href

$scriptTags = ''
foreach ($source in $scripts) {
  $scriptTags += "<script src='$source' defer></script>"
}

foreach ($link in $cssLinks) {
  $scriptTags += "<link rel='stylesheet' href='$link'>"
}
$scriptTags += '</head>'

Write-Host "Tags found: = $($scriptTags)"

$htmlContent -replace '</head>', $scriptTags | 
Set-Content $buildFile -Force