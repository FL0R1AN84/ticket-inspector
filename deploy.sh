#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the app and check if the build is successful
npm run build

# Read version from package.json
VERSION=$(grep -o '"version": "[^"]*' package.json | grep -o '[^"]*$')

# Update MARKETING_VERSION in ios/App/App.xcodeproj/project.pbxproj
sed -i '' "s/MARKETING_VERSION = [^;]*/MARKETING_VERSION = $VERSION/" ios/App/App.xcodeproj/project.pbxproj

# Get the current date in the desired format
DATE_NOW=$(date +%Y%m%d%H%M%S)

# Update CURRENT_PROJECT_VERSION in ios/App/App.xcodeproj/project.pbxproj with the current date
sed -i '' "s/CURRENT_PROJECT_VERSION = [^;]*/CURRENT_PROJECT_VERSION = $DATE_NOW/" ios/App/App.xcodeproj/project.pbxproj

# Check if android folder exists
if [ -d "android" ]; then
  echo "android folder already exists, doing nothing"
else
  ionic cap add android
fi

# Build and sync android
ionic build --prod
npx cap sync android
npx cap copy android

# Check if ios folder exists
if [ -d "ios" ]; then
  echo "ios folder already exists, doing nothing"
else
  ionic cap add ios
fi

# Sync and copy ios
npx cap sync ios
npx cap copy ios