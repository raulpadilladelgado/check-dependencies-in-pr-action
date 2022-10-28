#!/bin/sh -l

chmod +x gradlew
./gradlew dependencyUpdates -Drevision=release -DoutputFormatter=json
outdated=$(jq -r '.outdated.dependencies | .[] | "\(.name) \(.version) => \(.available.release)"' build/dependencyUpdates/report.json)
if [ -z "$outdated" ];
then
  outdated="Congratulations, all your dependencies have the latest releases!"
else
  outdated=$(echo "$outdated" | sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g')
fi

curl \
  -X POST \
  "$1" \
  -H "Content-Type: application/json" \
  -H "Authorization: token $2" \
  -d \
  "
  {
        \"body\": \"**Dependencies with newer available releases:**\n$outdated\"
  }
  "