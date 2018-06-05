git log $(git describe --tags --abbrev=0)..HEAD --pretty=format:"%h %s"
