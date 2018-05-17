# Appodeal Cordova Plugin

This is an official Appodeal Cordova plugin, created to support Appodeal SDK with Apache Cordova.

# How to Update Plugin Manually

### Android Part:

+ Download new Appodeal Android SDK [here](https://www.appodeal.com/sdk/documentation?framework=1&full=1&platform=1) and unzip it somewhere.
+ Copy jars except `android-support-v7-recyclerview` (it is needed for native ads witch is not supported by Cordova plugin) into `libs/Android`.
+ aar libraries from `aar` folder should be unzipped and composed into ant libraries, you can check how it should be structured on existing libraries in [Android](/libs/Android/) folder.
+ Open `plugin.xml` file, scroll down to the end of android platform tag, edit `source-file` tags (it should be equal to the jar names, you've put into `libs/Android` folder) and `framework` tags (should be equal to the library folders, you've composed from aar libraries).
+ Copy new `AndroidManifest.xml` tags from [Appodeal Android Docs](https://www.appodeal.com/sdk/documentation?framework=1&full=1&platform=1) page and replace old with new inside `<config-file parent="/manifest/application" target="AndroidManifest.xml">`.
+ Check [AppodealPlugin.java](/src/android/AppodealPlugin.java) for any API changes.
+ Done, you can use updated plugin for Android Platform.

### iOS Part:

+ Download new Appodeal iOS SDK [here](https://www.appodeal.com/sdk/documentation?framework=20&full=1&platform=4) and unzip it somewhere.
+ Remove [Adapters](/libs/iOS/Adapters/) folder and [Appodeal.bundle](/libs/iOS/Appodeal/). Replace old `Appodeal.framework` with new one and put `Resources` folder if exists into [libs/iOS/Appodeal](/libs/iOS/Appodeal).
+ Open [plugin.xml](/plugin.xml), scroll down to `<platform name="ios">` and check system frameworks for any changes due to changes in 3 Step of 5.3 Manual Integration in [Appodeal iOS Doc page](https://www.appodeal.com/sdk/documentation?framework=20&full=1&platform=4).
+ Remove all the content after `<framework custom="true" src="libs/iOS/Appodeal/Appodeal.framework"/>` in [plugin.xml](/plugin.xml) up to `</platform>` close tag. 
+ Skip this step if unzipped iOS SDK does not contain `Resources` folder. Add all resources from `Resources` folder of unzipped iOS SDK manually after `<framework custom="true" src="libs/iOS/Appodeal/Appodeal.framework"/>`, for example: 

```xml
<resource-file src="libs/iOS/Appodeal/Resources/MPCloseBtn.png"/>
```

+ Check [AppodealPlugin.m](/scr/ios/AppodealPlugin.m) for any API changes.
+ Done, you can use updated plugin for iOS Platform.

## Install

Simply go to the project folder over console/terminal and run there following command:

    cordova plugin add https://github.com/appodeal/appodeal-cordova-plugin.git

Google Play Services (v10+) already included to plugin dependencies.

If you have issues while installing plugin, follow the Command-line Interface Guide.

Minimum OS requirements: 

+ iOS 8.1
+ Android API level 14 (Android OS 4.0)

Appodeal SDK included:

+ Android Appodeal SDK version 2.1.11
+ iOS Appodeal SDK version 2.1.10


## Changelog

3.0.5 (21.04.2018)

+ Appodeal iOS SDK updated to 2.1.10
+ Appodeal Android SDK updated to 2.1.11
+ Ogury for Android added as required library

3.0.2 (20.09.2017)

+ Appodeal iOS SDK updated to 2.1.4
+ Appodeal Android SDK updated to 2.1.4
+ Refactoring
+ Play services resolver added
+ Appodeal.setLogging renamed to Appodeal.setLogLevel
+ Appodeal.setChildDirectedTreatment added
+ Appodeal.muteVideosIfCallsMuted added
+ Appodeal.showTestScreen added (supported by Adnroid only atm)
+ Appodeal.canShowWithPlacement added
+ Appodeal.getRewardParameters added
+ Appodeal.getRewardParametersForPlacement added


3.0.0 (14.06.2017)

+ Appodeal iOS SDK updated to 2.0.0
+ Appodeal Android SDK updated to 2.0.2
+ Appodeal.confirm removed
+ Appodeal.canShow added
+ SetOnLoadedTriggerBoth renamed to setTriggerOnLoadedOnPrecache
+ callbacks reworked
+ optional permissions to AndroidManifest added
