param ([string]$dir=$env:HomePath)
#Get first directory entry in a directory, 
#sorted by date, and only showing the file name without column header
"Getting first directory entry for '$dir'"
get-childitem $dir | Sort-Object date | Select-Object -first 1 | Select Name | Format-Table -hidetableheaders
