#!/bin/bash
set -v
curl -fSL https://github.com/haya14busa/reviewdog/releases/download/$REVIEWDOG_VERSION/reviewdog_linux_amd64 -o reviewdog && chmod +x reviewdog
npx eslint -f checkstyle src/js | ./reviewdog -f=checkstyle -diff="git diff $TRAVIS_BRANCH" -reporter=github-pr-review
