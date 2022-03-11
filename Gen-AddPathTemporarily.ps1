param ([string]$newPathToAdd)

"Adding '$newPathToAdd' to current path settings for this session only."
$currPath = get-item env:path
$newPath = $currPath.Value + ";" + $newPathToAdd
set-item env:path $newPath

"Done."

