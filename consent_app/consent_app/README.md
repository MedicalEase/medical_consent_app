# consent_app

Release bundle id updating command:
>> flutter build appbundle --build-name=1.0.4+4 --build-number=4
> does this override the version in appspec? hmm
> then cd ios and run
> flutter clean
 ios % pod deintegrate
 ios % pod install

Then run a publish / archive in xcode
then upload the .ipa via transporter

## Getting Started

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

For other languages dont forget to add video paths in the pubspec.yaml file

Xcode build 
https://flutter.dev/docs/deployment/ios#build-an-archive-of-the-app
* open xcode and open the ios/Runner.xcworkspace file
* select product -> archive
* distribute using xcode distribute to create an .ipa file
* upload the .ipa file