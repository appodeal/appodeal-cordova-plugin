# Appodeal Cordova Plugin

This is an official Appodeal Cordova plugin, created to support Appodeal SDK with Apache Cordova.

## SDK
[![](https://img.shields.io/badge/docs-here-green.svg)](appodeal.com/sdk/cordova2)

## Install

Simply go to the project folder over console/terminal and run there following command:

    cordova plugin add https://github.com/appodeal/appodeal-cordova-plugin.git

Google Play Services (v10+) already included to plugin dependencies.

If you have issues while installing plugin, follow the Command-line Interface Guide.

Minimum OS requirements: 

+ iOS 8.1
+ Android API level 14 (Android OS 4.0)

Appodeal SDK included:

+ Android Appodeal SDK version 2.1.4
+ iOS Appodeal SDK version 2.1.4


## Changelog

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
