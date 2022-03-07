#=== Copy file from original location === 
$path = "../public/index.html"
$srcFile = ".\index.html"  # source file that has the insert marker  
Copy-Item -Path $path -Destination $srcFile

#=== Add script lines to file === 
$scriptTags = 
'<script defer="defer" src="/static/js/main.3d6d2a62.js"></script>
  <link href="/static/css/main.073c9b0a.css" rel="stylesheet">'
$scriptTags | Out-File -FilePath '.\content.txt'

#=== Write the index file to the output file === 
$textToInsert = '.\content.txt'
$srcFile = ".\index.html"  # source file that has the insert marker  
$dstFile = ".\index2.html"  # destination file for combined input
 
$pattern = [regex]'<title>'
$lineNum = (Select-String -Pattern $pattern -Path $srcFile).lineNumber
Write-Verbose "Inserting at line number:  $lineNum"
 
Invoke-Command { 
  Get-Content -Path $srcFile | select -First $lineNum
  Get-Content -Path $textToInsert
  Get-Content -Path $srcFile | select -Skip $lineNum
} | Set-Content -Path $dstFile -Force