#Appodeal Cordova Plugin

This is an official Appodeal Cordova plugin, created to support Appodeal SDK with Apache Cordova.

##SDK
[![](https://img.shields.io/badge/docs-android-green.svg)](http://www.appodeal.com/sdk/documentation?framework=9&full=1&platform=1)
[![](https://img.shields.io/badge/docs-ios-green.svg)](http://www.appodeal.com/sdk/documentation?framework=9&full=1&platform=2)

##Install

Simply go to the project folder over console/terminal and run there following command:

    cordova plugin add https://github.com/appodeal/appodeal-cordova-plugin.git

For Android You don't need to make something additional.

## Testing
In the Tests folder of this plugin you can find some tests. To run these tests you need:
1. Use your existing cordova app, or create a new one.
2. Add the following plugin:
   ```
   cordova plugin add http://git-wip-us.apache.org/repos/asf/cordova-plugin-test-framework.git
   ```
3. Change the start page in config.xml with `<content src="cdvtests/index.html" />` or navigate to cdvtests/index.html from within your app.
4. Add appodeal cordova plugin.
5. Add tests folder to your app as a plugin.
6. Run your app.


##Changelog

2.1.0 (20.11.2016)

+ Appodeal iOS SDK updated to 1.3.3
+ Appodeal Android SDK updated to 1.15.7
+ resetUUID (iOS Only) removed

2.0.0 (30.09.2016)

+ Appodeal iOS SDK 1.2.4 now included
+ Appodeal Android SDK updated to 1.15.5
+ Small bugfixes
