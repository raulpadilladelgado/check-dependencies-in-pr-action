#!/bin/sh -l

chmod +x gradlew
./gradlew dependencyUpdates -Drevision=release -DoutputFormatter=json
outdated=$(jq -r '.outdated.dependencies | .[] | "\(.name) \(.version) -> \(.available.release)"' <build/dependencyUpdates/report.json)
if [ -z "$outdated" ]; then
  echo "Congratulations, all your dependencies have the latest releases!"
  exit 0
fi

echo "$1"
echo "$2"
echo "$outdated"

curl \
  -X POST \
  "$1" \
  -H "Content-Type: text/plain" \
  -H "Authorization: token $2" \
  --data '{ "body": '"$outdated"' }'
