## Getting Started

Enter your API key for Google Maps in the `android/app/src/main/AndroidManifest.xml` file:
 # <meta-data android:name="com.google.android.geo.API_KEY"
 # android:value="YOUR_GOOGLE_API_KEY"/>

Enter your API key for Google Maps in the `ios/Runner/AppDelegate.swift` file:
# GMSServices.provideAPIKey("YOUR_GOOGLE_API_KEY")

```bash
flutter run -t lib/main.dart --dart-define API_KEY=YOUR_KEY --dart-define SERVER_URL=YOUR_SERVER_URL
```
# Build APK

```bash
flutter build appbundle --dart-define API_KEY=YOUR_KEY --dart-define SERVER_URL=YOUR_SERVER_URL
```
# Build iOS

```bash
flutter build ipa --dart-define API_KEY=YOUR_KEY --dart-define SERVER_URL=YOUR_SERVER_URL
```