#!/bin/sh -l

chmod +x gradlew
./gradlew dependencyUpdates -Drevision=release -DoutputFormatter=json
outdated=$(jq -r '.outdated.dependencies | .[] | "\(.name) \(.version) -> \(.available.release)"' < build/dependencyUpdates/report.json)
if [ -z "$outdated" ] ; then
  echo "Congratulations, all your dependencies have the latest releases!"
  exit 1
fi
echo "outdated<<EOF" >> $GITHUB_ENV
echo "$outdated" >> $GITHUB_ENV
echo "EOF" >> $GITHUB_ENV
