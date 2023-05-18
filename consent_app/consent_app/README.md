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

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
