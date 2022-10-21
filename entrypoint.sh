#!/bin/sh -l

chmod +x gradlew
./gradlew dependencyUpdates -Drevision=release -DoutputFormatter=json
outdated=$(jq -r '.outdated.dependencies | .[] | "\(.name) \(.version) -> \(.available.release)"' < build/dependencyUpdates/report.json)
if [ -z "$outdated" ] ; then
  echo "Congratulations, all your dependencies have the latest releases!"
  exit 0
fi
echo "outdated<<EOF" >> $GITHUB_ENV
echo "$outdated" >> $GITHUB_ENV
echo "EOF" >> $GITHUB_ENV

echo "$PULL_REQUEST_URL"
echo $2

curl \
  -X POST \
  $1 \
  -H "Content-Type: application/json" \
  -H "Authorization: token $2" \
  --data '{ "body": "blah blah" }'
