## General infos for local development

For the first build (includes livereload) on local simulator devices

```bash
npm run build
```

### Requirements

```bash
npm install @capacitor/android
```

```bash
npx cap add android
```

- Java Version 21
- Android Studio

```bash
brew install --cask android-studio
```

.zshrc

```text
# Android SDK
alias adb="/Users/$USER/Library/Android/sdk/platform-tools/./adb"
export ANDROID_SDK_ROOT="/Users/$USER/Library/Android/sdk"
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator/
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jbr/Contents/Home
```

### Device simulator

```bash
npx cap run android
```

---

[back to Index](../README.md)
