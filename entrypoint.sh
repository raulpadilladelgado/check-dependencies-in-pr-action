#!/bin/sh -l

chmod +x gradlew
./gradlew dependencyUpdates -Drevision=release -DoutputFormatter=json
outdated=$(jq -r '.outdated.dependencies | .[] | "\(.name) \(.version) => \(.available.release)"' build/dependencyUpdates/report.json)
if [ -z "$outdated" ]; then
  outdated="Congratulations, all your dependencies have the latest releases!"
fi

curl \
  -X POST \
  "$1" \
  -H "Content-Type: application/json" \
  -H "Authorization: token $2" \
  -d \
  "
  {
        \"body\": \"$outdated\"
  }
  "