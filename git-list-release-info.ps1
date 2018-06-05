#This script will get last tag from HEAD backwards in history
$lastTag = git describe --tags --abbrev=0
"Last tag in history from HEAD is [$lastTag]"
$releaseNotes = git log "$lastTag..HEAD" --pretty=format:"%h %s"
$releaseNotes
