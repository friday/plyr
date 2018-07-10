#!/bin/bash
if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo "Skipping code review. Build is not a PR."
  exit 0
fi

if [ -z "$REVIEWDOG_GITHUB_API_TOKEN" ]; then
  echo "Token not set"
fi

echo "Branch: $TRAVIS_BRANCH"
echo "Downloading reviewdog"
curl -fSL https://github.com/haya14busa/reviewdog/releases/download/$REVIEWDOG_VERSION/reviewdog_linux_amd64 -o reviewdog && chmod +x reviewdog

echo "Running reviewdog"

# Lint
npx eslint -f checkstyle src/js > eslint.checkstyle.xml
cat eslint.checkstyle.xml | ./reviewdog -f=checkstyle -diff="git diff $TRAVIS_COMMIT_RANGE" -reporter=github-pr-check
cat eslint.checkstyle.xml | ./reviewdog -f=checkstyle -diff="git diff $TRAVIS_COMMIT_RANGE" -reporter=github-pr-review

# Ignore any exit status
exit 0
