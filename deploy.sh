#!/bin/bash

# Read version from package.json
VERSION=$(grep -o '"version": "[^"]*' package.json | grep -o '[^"]*$')

# Update CURRENT_PROJECT_VERSION in ios/App/App.xcodeproj/project.pbxproj
sed -i '' "s/CURRENT_PROJECT_VERSION = [^;]*/CURRENT_PROJECT_VERSION = $VERSION/" ios/App/App.xcodeproj/project.pbxproj

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