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

Appodeal Cordova Plugin includes:

+ Android Appodeal SDK version 2.1.11
+ iOS Appodeal SDK version 2.1.10

## Cordova Integration

### Ad Types

+ Appodeal.INTERSTITIAL
+ Appodeal.BANNER
+ Appodeal.REWARDED_VIDEO
+ Appodeal.NON_SKIPPABLE_VIDEO

Ad types can be combined using "|" operator. For example Appodeal.INTERSTITIAL | Appodeal.NON_SKIPPABLE_VIDEO.

### SDK Initialization

To initialize SDK for INTERSTITIAL ad type, call the following code:

```javascript
var appKey = "e7e04e54ae0a8d28cff2f7e7e7d094e78b2a09743be2cc4a";
Appodeal.disableLocationPermissionCheck();
Appodeal.initialize(appKey, Appodeal.INTERSTITIAL);
```

+ To initialize only interstitials use `Appodeal.initialize(appKey, Appodeal.INTERSTITIAL)`
+ To initialize only rewarded video use `Appodeal.initialize(appKey, Appodeal.REWARDED_VIDEO)`
+ To initialize only non-skippable video use `Appodeal.initialize(appKey, Appodeal.NON_SKIPPABLE_VIDEO)`
+ To initialize interstitials and non-skippable videos use `Appodeal.initialize(appKey, Appodeal.INTERSTITIAL | Appodeal.NON_SKIPPABLE_VIDEO)`
+ To initialize only banners use `Appodeal.initialize(appKey, Appodeal.BANNER)`

### Display Ad

To display ad you need to call the following code:

```javascript
Appodeal.show(adTypes);
```

+ To display interstitial use `Appodeal.show(Appodeal.INTERSTITIAL)`
+ To display rewarded video use `Appodeal.show(Appodeal.REWARDED_VIDEO)`
+ To display non-skippable video use `Appodeal.show(Appodeal.NON_SKIPPABLE_VIDEO)`
+ To display interstitial or non-skippable video use `Appodeal.show(Appodeal.INTERSTITIAL | Appodeal.NON_SKIPPABLE_VIDEO)`
+ To display banner at the bottom of the screen use `Appodeal.show(Appodeal.BANNER_BOTTOM)`
+ To display banner at the top of the screen use `Appodeal.show(Appodeal.BANNER_TOP)`

Also it can be used in this way, to get boolean value if ad was successfully shown:

```javascript
Appodeal.show(adTypes, function(result) {
   // result is a boolean value, that is indicates whether show call was passed to appropriate SDK 
});
```

### Checking if interstitial is loaded

To check if ad type was loaded, use following code:

```javascript
Appodeal.isLoaded(adTypes, function(result){
    // result returns bool value
});
```

### Hide Banner Ad

To hide banner you need to call the following code:

```javascript
Appodeal.hide(Appodeal.BANNER);
```

### Callbacks integration

To set Interstitial callbacks, use following code:

```javascript
Appodeal.setInterstitialCallbacks( function(container) {
       if (container.event == 'onLoaded') {
            console.log("Appodeal. Interstitial. " + container.event + ", isPrecache: " + container.isPrecache  );
            // your code
       } else if (container.event == 'onFailedToLoad') {
            // your code
       } else if (container.event == 'onShown') {
            // your code
       } else if (container.event == 'onClick') {
            // your code
       } else if (container.event == 'onClosed') {
            // your code
       }
});
```

To set Banner callbacks, use following code:

```javascript
Appodeal.setBannerCallbacks( function(container) {
       if (container.event == 'onLoaded') {
            console.log("Appodeal. Banner. " + container.event + ", height: " + container.height + ", isPrecache: " + container.isPrecache);
            // your code
       } else if (container.event == 'onFailedToLoad') {
            // your code
       } else if (container.event == 'onShown') {
            // your code
       } else if (container.event == 'onClick') {
            // your code
       }
});
```

To set Rewarded Video callbacks, use following code:

```javascript
Appodeal.setRewardedVideoCallbacks( function(container) {
       if (container.event == 'onLoaded') {
            // your code
       } else if (container.event == 'onFailedToLoad') {
            // your code
       } else if (container.event == 'onShown') {
            // your code
       } else if (container.event == 'onFinished') {
            // container also returns "name" and "amount" variables with reward amount and currency name you have set for your application
            console.log( "Appodeal. Rewarded. " + container.event + ", amount: " + container.amount + ", name: " + container.name);
            // your code
       } else if (container.event == 'onClosed') {
            // container also returns "finished" variable with boolean value for indicating if video was finished
            console.log("Appodeal. Rewarded. " + container.event + ", finished: " + container.finished);
            // your code
       }
});
```

To set Non Skippable Video callbacks, use following code:

```javascript
Appodeal.setNonSkippableVideoCallbacks( function(container) {
       if (container.event == 'onLoaded') {
            // your code
       } else if (container.event == 'onFailedToLoad') {
            // your code
       } else if (container.event == 'onShown') {
            // your code
       } else if (container.event == 'onFinished') {
            // your code
       } else if (container.event == 'onClosed') {
            // container also returns "finished" variable with boolean value for indicating if video was finished
            console.log("Appodeal. Non Skippable Video. " + container.event + ", finished: " + container.finished);
            // your code
       }
});
```

### Advanced Features

#### Getting reward data for placement

To get placement reward data before video is shown use:

```javascript
Appodeal.getRewardParameters( function(result) {
   console.log("Appodeal Reward Amount:" + result.amount);
   console.log("Appodeal Reward Currency:" + result.currency);
});
```

#### Enabling 728*90 banners

To enable 728*90 banner use the following method:

```javascript
Appodeal.set728x90Banners(true);
```

#### Disabling banner refresh animation

To disable banner refresh animation use:

```javascript
Appodeal.setBannerAnimation(false);
```

#### Disabling smart banners

```javascript
Appodeal.setSmartBanners(false);
```

#### Enabling test mode

```javascript
Appodeal.setTesting(true);
```

In test mode test ads will be shown and debug data will be written to log.

#### Enabling logging

```javascript
Appodeal.setLogLevel(Appodeal.LogLevel.debug);
```

Available parameters: Appodeal.LogLevel.none, Appodeal.LogLevel.debug, Appodeal.LogLevel.verbose.

#### Checking if loaded ad is precache

```javascript
Appodeal.isPrecache(adTypes, function(result){
  // result is a boolean value, that equals true if ad is precache
})
```

Currently supported only for interstitials and banners

To check if loaded interstitial is precache: use `Appodeal.isPrecache(Appodeal.INTERSTITIAL);`

To check if loaded banner is precache: use `Appodeal.isPrecache(Appodeal.BANNER);`

#### Manual ad caching

```javascript
Appodeal.cache(adTypes);
```

+ You should disable automatic caching before SDK initialization using `setAutoCache(adTypes, false)`.
+ To cache interstitial use `Appodeal.cache(Appodeal.INTERSTITIAL)`
+ To cache rewarded video use `Appodeal.cache(Appodeal.REWARDED_VIDEO)`
+ To cache interstitial and non-skippable video use `Appodeal.cache(Appodeal.INTERSTITIAL | Appodeal.NON_SKIPPABLE_VIDEO)`
+ To cache banner use `Appodeal.cache(Appodeal.BANNER)`

#### Enabling or disabling automatic caching

```javascript
Appodeal.setAutoCache(adTypes, false);
```

+ Should be used before SDK initialization
+ To disable automatic caching for interstitials use `Appodeal.setAutoCache(Appodeal.INTERSTITIAL, false)`
+ To disable automatic caching for rewarded videos use `Appodeal.setAutoCache(Appodeal.REWARDED_VIDEO, false)`
+ To disable automatic caching for banners use `Appodeal.setAutoCache(Appodeal.BANNER, false)`

#### Triggering onLoaded callback on precache

```javascript
Appodeal.setTriggerOnLoadedOnPrecache(adTypes, true);
```

+ Currently supported only for interstitials
+ `setOnLoadedTriggerBoth(Appodeal.INTERSTITIAL, false)` - onInterstitialLoaded will trigger only when normal ad was loaded (default)..
+ `setOnLoadedTriggerBoth(Appodeal.INTERSTITIAL, true)` - onInterstitialLoaded will trigger twice, both when precache and normal ad were loaded..
+ Should be used before SDK initialization

#### Disabling data collection for kids apps

```javascript
Appodeal.setChildDirectedTreatment(true);
```

#### Disabling networks

```javascript
Appodeal.disableNetwork(network);
```

Available parameters: "adcolony", "admob", "amazon_ads", "applovin", "appnext", "avocarrot", "chartboost", "facebook", "flurry", "inmobi", "inner-active", "ironsource", "mailru", "mmedia", "mopub", "ogury", "openx", "pubnative", "smaato", "startapp", "tapjoy", "unity_ads", "vungle", "yandex"

Should be used before SDK initialization

#### Disabling location permission check

To disable toast messages ACCESS_COARSE_LOCATION permission is missing, use the following method:

```javascript
Appodeal.disableLocationPermissionCheck();
```

Should be used before SDK initialization.

#### Disabling write external storage permission check

To disable toast messages WRITE_EXTERNAL_STORAGE permission is missing use the following method:

```javascript
Appodeal.disableWriteExternalStoragePermissionCheck();
```

Disables all ad networks that need this permission may lead to low video fillrates.

Should be used before SDK initialization.

#### Tracking in-app purchase

```javascript
Appodeal.trackInAppPurchase(this, 5, "USD");
```

#### Testing third-party networks adapters integration

To show test screen for testing adapters integration call:

```javascript
Appodeal.showTestScreen();
```

#### Muting videos if call volume is muted

```javascript
Appodeal.muteVideosIfCallsMuted(true);
```

### Setting User Data

#### Set the age of the user

```javascript
Appodeal.setAge(25);
```

#### Specify gender of the user

```javascript
Appodeal.setGender(UserSettings.Gender.FEMALE);
```

Possible values: Appodeal.Gender.FEMALE, Appodeal.Gender.MALE, Appodeal.Gender.OTHER.

## Changelog

3.0.5 (21.04.2018)

+ Appodeal iOS SDK updated to 2.1.10
+ Appodeal Android SDK updated to 2.1.11
+ Ogury for Android added as required library
