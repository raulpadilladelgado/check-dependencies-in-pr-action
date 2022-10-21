#!/bin/sh -l

chmod +x gradlew
./gradlew dependencyUpdates -Drevision=release -DoutputFormatter=json
outdated=$(jq -r '.outdated.dependencies | .[] | "\(.name) \(.version) -> \(.available.release)"' < build/dependencyUpdates/report.json)
echo "outdated=$outdated" >>$GITHUB_OUTPUT
