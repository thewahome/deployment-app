$srcFile = ".\index.html"  # source file that has the insert marker 

#=== Fetch file from the set location === 
Invoke-WebRequest https://gewayhome.z13.web.core.windows.net | 
Select-Object -ExpandProperty Content | 
Out-File $srcFile 

#=== Add script lines to file === 
$scriptTags = 
'<script defer="defer" src="/static/js/main.3d6d2a62.js"></script>
  <link href="/static/css/main.073c9b0a.css" rel="stylesheet">'
$scriptTags += '</head>'

(Get-Content $srcFile) -replace '</head>', $scriptTags | 
	Set-Content $srcFile