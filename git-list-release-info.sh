#See https://discuss.bitrise.io/t/how-to-generate-release-notes-changelog-from-git-commits-since-last-git-tag/2941
git log $(git describe --tags --abbrev=0)..HEAD --pretty=format:"%h %s"
