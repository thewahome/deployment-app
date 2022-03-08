#=== Source script line from build file === 
$buildFile = '../public/index.html'
$content = Get-Content -Path $buildFile -Raw 
$html = New-Object -ComObject "HTMLFile"
$html.IHTMLDocument2_write($content)
$scripts = $html.all.tags('script') | ForEach-Object src


#=== Generate script lines === 
$scriptTags = ''
foreach ($source in $scripts) {
  $scriptTags += "<script src='$source'></script>"
}
$scriptTags += '</head>'

(Get-Content $buildFile) -replace '</head>', $scriptTags | 
	Set-Content $buildFile