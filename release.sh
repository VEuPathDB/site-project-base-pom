#!/bin/bash

if [ "$GITHUB_USERNAME" == "" ]; then
    echo 'Environment variable $GITHUB_USERNAME must be set'
    exit 1
fi
if [ "$GITHUB_TOKEN" == "" ]; then
    echo 'Environment variable $GITHUB_TOKEN must be set'
    exit 1
fi
echo "Github credentials for $GITHUB_USERNAME found in environment"

echo "Fetching settings.xml" \
     && curl -O https://raw.githubusercontent.com/VEuPathDB/base-pom/main/settings.xml \
     && echo "Preparing release..." \
     && mvn -Dusername=git release:prepare \
     && echo "Prepare successful; deploying artifacts" \
     && mvn release:perform --settings ./settings.xml \
     && echo "Release succeeded. Cleaning up." \
     && git push

echo "Done."
