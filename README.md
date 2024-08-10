# iquranic

A Electronic Quran app that helps you to read, understand, and
search the Quran. It also has a feature to listen to the Quran recitation.

## Getting Started

### Firebase Configuration
1. Make sure you have `firebase-tools` on npm installed already
2. Also make sure you have `flutterfire_cli` on dart installed already
3. To install `firebase-tools` and `flutterfire_cli` run commands below:
```shell
# install firebase-tools
npm install -g firebase-tools

# after install you need login first to firebase, to login execute command below:
firebase login

# after login, next install flutterfire_cli
dart pub global activate flutterfire_cli

# after that run command below to generate firebase_options.dart
# also make sure you have already created project on firebase
flutterfire configure --out lib/firebase/options/firebase_options.dart
```

### Facebook Configuration
1. Rename file `strings.example.xml` on `android/app/src/main/res/values/strings.example.xml` to `strings.xml`
2. Replace `YOUR_APP_ID` and `YOUR_CLIENT_TOKEN` to your own configuration
```xml
<string name="facebook_app_id">YOUR_APP_ID</string>
<string name="facebook_client_token">YOUR_CLIENT_TOKEN</string>
```