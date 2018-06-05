#This script will get last tag from HEAD backwards in history
# see https://discuss.bitrise.io/t/how-to-generate-release-notes-changelog-from-git-commits-since-last-git-tag/2941
$lastTag = git describe --tags --abbrev=0
"Last tag in history from HEAD is [$lastTag]"
$releaseNotes = git log "$lastTag..HEAD" --pretty=format:"%h %s"
$releaseNotes
