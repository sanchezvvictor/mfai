# Script to build and publish mfai using runai (MF internal docker wrapper)

# Check if the repo is on a tag and if there is local modifications
set -e
git_tag=$(git describe --tags --abbrev=0 --exact-match)
if [ -n "$(git status --porcelain)" ]; then
    echo "Error: You are on a git tag but there are local modifications. Please stash them or commit, push and tag your modifications."
    exit 1
fi

runai exec python -m build
# Use first arg if provided, otherwise use testpypi
runai exec python -m twine upload --verbose --repository ${1:-"testpypi"} dist/*
