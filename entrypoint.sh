#!/bin/sh -l

chmod +x gradlew
./gradlew dependencyUpdates -Drevision=release -DoutputFormatter=json
outdated=$(jq -r '.outdated.dependencies | .[] | "\(.name) \(.version) -> \(.available.release)"' < build/dependencyUpdates/report.json)
echo "outdated<<EOF" >> $GITHUB_ENV
echo "$outdated" >> $GITHUB_ENV
echo "EOF" >> $GITHUB_ENV
