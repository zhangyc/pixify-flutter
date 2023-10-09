# sona

A new Flutter project.

## Build

## Test
### APK
flutter build apk --split-per-abi --dart-define=ENV=prod
flutter build apk --split-per-abi --dart-define=ENV=test
### IPA
flutter build ip --release --export-method=ad-hoc --dart-define=ENV=prod
flutter build ip --release --export-method=ad-hoc --dart-define=ENV=test

## Release
### AAR
flutter build appbundle --obfuscate --split-debug-info=build/app/outputs/bundle/release/ --dart-define=ENV=prod
### IPA
flutter build ipa --release --dart-define=ENV=prod