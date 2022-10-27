#!/bin/sh -l

chmod +x gradlew
./gradlew dependencyUpdates -Drevision=release -DoutputFormatter=json
outdated=$(jq -r '.outdated.dependencies | .[] | "\(.name)\\\\n-\(.version)\\\\n+\(.available.release)\\\\n"' build/dependencyUpdates/report.json)
if [ -z "$outdated" ]; then
  echo "Congratulations, all your dependencies have the latest releases!"
  exit 0
fi

curl \
  -X POST \
  "$1" \
  -H "Content-Type: application/json" \
  -H "Authorization: token $2" \
  -d \
  "
  {
        \"body\": \"**Dependencies with newer available releases:**\n\`\`\`diff\n$outdated\`\`\`\"
  }
  "

curl \
  -X POST \
  "https://api.github.com/repos/raulpadilladelgado/aguacate/issues/2/comments" \
  -H "Content-Type: application/json" \
  -H "Authorization: token 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" \
  -d \
  "
  {
        \"body\": \"**Dependencies with newer available releases:**\n\`\`\`diff\naguacate\n-1.2\n+2.3\n\`\`\`\"
  }
  "